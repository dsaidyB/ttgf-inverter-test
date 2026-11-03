## How it works

A single CMOS inverter built from gf180mcu 3.3 V devices (NMOS W = 1 um, PMOS W = 2.5 um, L = 0.28 um). The input is on ua[1] and the output on ua[0]. This is a dry run of the analog flow before the PLL.

## How to test

Apply a 0 to 3.3 V square wave to ua[1] and watch ua[0] on an oscilloscope: it should be the inverted input. Keep the frequency below about 1 MHz, since the analog pin path is roughly 500 ohm and 5 pF.

## External hardware

Function generator and oscilloscope.
