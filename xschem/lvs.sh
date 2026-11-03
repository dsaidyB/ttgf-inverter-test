#!/bin/bash
# lvs.sh - one-command LVS for a gf180mcuD cell (Xschem schematic vs Magic layout)
# Usage (from ~/pll):  ./lvs.sh inverter

set -u

CELL="${1:?Usage: ./lvs.sh <cell name>   e.g. ./lvs.sh inverter}"

PDK=/usr/local/share/pdk/gf180mcuD
MAGICRC="$PDK/libs.tech/magic/gf180mcuD.magicrc"
NETGEN_SETUP="$PDK/libs.tech/netgen/gf180mcuD_setup.tcl"

OUT=./lvs
mkdir -p "$OUT"

SCH_NET="$OUT/${CELL}_sch.spice"
LAY_NET="$OUT/${CELL}_layout.spice"
REPORT="$OUT/${CELL}_comp.out"

for f in "$CELL.sch" "$CELL.mag" "$MAGICRC" "$NETGEN_SETUP"; do
    if [ ! -f "$f" ]; then
        echo "ERROR: missing $f"
        exit 1
    fi
done

echo "[1/4] Netlisting schematic $CELL.sch ..."
rm -f "$OUT/$CELL.spice"
xschem -n -s -q -x -o "$OUT" \
    --tcl "set lvs_netlist 1; set top_subckt 1; set spiceprefix 1" \
    "$CELL.sch" > "$OUT/xschem.log" 2>&1

if [ ! -f "$OUT/$CELL.spice" ]; then
    echo "ERROR: Xschem did not write $OUT/$CELL.spice - see $OUT/xschem.log"
    exit 1
fi
mv "$OUT/$CELL.spice" "$SCH_NET"

if ! grep -qi "^\.subckt $CELL" "$SCH_NET"; then
    echo "ERROR: schematic netlist has no '.subckt $CELL' line - see $SCH_NET"
    exit 1
fi

echo "[2/4] Fixing device prefix (M -> XM) ..."
sed -i 's/^M/XM/' "$SCH_NET"

echo "[3/4] Extracting layout $CELL.mag ..."
magic -dnull -noconsole -rcfile "$MAGICRC" > "$OUT/magic.log" 2>&1 <<EOF
load $CELL
select top cell
extract all
ext2spice lvs
ext2spice -o $LAY_NET
quit -noprompt
EOF

if [ ! -f "$LAY_NET" ]; then
    echo "ERROR: Magic did not write $LAY_NET - see $OUT/magic.log"
    exit 1
fi

echo "[4/4] Running netgen LVS ..."
netgen -batch lvs "$LAY_NET $CELL" "$SCH_NET $CELL" "$NETGEN_SETUP" "$REPORT" \
    > "$OUT/netgen.log" 2>&1

echo
if grep -q "Circuits match uniquely" "$REPORT"; then
    echo "LVS PASS: $CELL - circuits match uniquely."
    exit 0
else
    echo "LVS FAIL: $CELL - end of report ($REPORT):"
    echo "------------------------------------------------------------"
    tail -40 "$REPORT"
    exit 1
fi
