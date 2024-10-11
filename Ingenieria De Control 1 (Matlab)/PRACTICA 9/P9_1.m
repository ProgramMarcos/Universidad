clear all;
dni =21050001; % Números del DNI del alumno
rng(dni);
ts=20+20*(rand-0.5) % Anotar el valor obtenido
s=tf('s');
G=(s+20)/s^2;
F=0.303*(s+0.869)/(s+0.263)

%figure(1)
%rlocus(G)

%sisotool

%C=0.01*s/(s+0.51575);

%GLC=feedback(G*C,1);

%figure(2)
%step(GLC)

%figure(3)
%rlocus(G*C)