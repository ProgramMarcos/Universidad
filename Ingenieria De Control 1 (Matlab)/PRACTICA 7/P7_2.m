clear all
s = tf('s');
DNI =21050001; % números DNI del alumno
rng(DNI);
dv = 0.01*rand
wn=1;
S1=0.2+dv;
S2=0.5+dv;
S3=0.7+dv;
S4=0.9+dv;
G1=wn^2/(s*(s+2*S1*wn));
G2=wn^2/(s*(s+2*S2*wn));
G3=wn^2/(s*(s+2*S3*wn));
G4=wn^2/(s*(s+2*S4*wn));