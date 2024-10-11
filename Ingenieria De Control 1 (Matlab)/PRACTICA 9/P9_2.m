clear all;
dni =21050001; % Números del DNI del alumno
rng(dni);
ts=32+10*(rand-0.5) % Anotar el valor obtenido
s=tf('s');
G=(s^2+0.2*s+2)/((s+0.2)*(s^2+0.2*s+3));
C=2.88*(s+0.1233)/s
F=1.04*(s+0.118)/(s+0.123)
