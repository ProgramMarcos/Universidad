clear all
s = tf('s');
DNI =21050001; % números DNI del alumno
rng(DNI);
K1 = 1 + 9*rand
p1 = 2 + 3*rand
K2 = 1 + 9*rand
p2 = 4 + 3*rand
Ga = K1*5/(s*(s+1)*(s/p1+1)); zpk(Ga)
Gb = (K2/8)/((s/2+1)*(s/p2+1)); zpk(Gb)
dv = 0.01*rand

