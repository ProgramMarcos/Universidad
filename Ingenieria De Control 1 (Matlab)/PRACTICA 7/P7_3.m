clear all
s = tf('s');
K=10;
T1=1;
T2=0.05;
L=(K*(1-T2*s))/((1+T1*s)*(1+T2*s))
nyquist(L)