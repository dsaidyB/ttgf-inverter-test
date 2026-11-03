v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 340 30 340 50 {
lab=GND}
C {inverter.sym} 190 10 0 0 {name=x1}
C {lab_pin.sym} 40 -10 0 0 {name=p1 sig_type=std_logic lab=in}
C {lab_pin.sym} 340 -10 2 0 {name=p2 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 340 10 2 0 {name=p3 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 20 150 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice ff
"}
C {code_shown.sym} 480 0 0 0 {name=NGSPICE only_toplevel=true 

value="
vdd vdd 0 3.3
vin in 0 pulse(0 3.3 1n 50p 50p 5n 10n)
cload out 0 10f
.control
save all
dc vin 0 3.3 0.01
meas dc vm find v(in) when v(out)=v(in)
plot v(in) v(out)
tran 1p 30n
meas tran tphl trig v(in) val=1.65 rise=1 targ v(out) val=1.65 fall=1
meas tran tplh trig v(in) val=1.65 fall=1 targ v(out) val=1.65 rise=1
plot v(in) v(out)
.endc
"}
C {gnd.sym} 340 50 0 0 {name=l1 lab=GND}
