v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 110 -80 120 -80 {
lab=vdd}
N 120 -80 120 -50 {
lab=vdd}
N 110 -50 120 -50 {
lab=vdd}
N 50 0 70 0 {
lab=in}
N 110 -0 130 0 {
lab=out}
N 110 80 110 100 {
lab=vss}
N 110 100 120 100 {
lab=vss}
N 110 -100 110 -80 {
lab=vdd}
N 110 -100 120 -100 {
lab=vdd}
N 70 -50 70 -0 {
lab=in}
N 70 0 70 50 {
lab=in}
N 110 -20 110 -0 {
lab=out}
N 110 0 110 20 {
lab=out}
N 110 50 120 50 {
lab=vss}
N 120 50 120 80 {
lab=vss}
N 110 80 120 80 {
lab=vss}
C {symbols/nfet_03v3.sym} 90 50 0 0 {name=M1
L=0.28u
W=1u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 90 -50 0 0 {name=M2
L=0.28u
W=2.5u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {ipin.sym} 50 0 0 0 {name=p1 lab=in}
C {iopin.sym} 120 -100 0 0 {name=p2 lab=vdd}
C {iopin.sym} 120 100 0 0 {name=p3 lab=vss}
C {opin.sym} 130 0 0 0 {name=p4 lab=out}
