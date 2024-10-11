clear all
close all
s = tf('s');
dni=21050001 ; % Incluir DNI alumno
rng(dni);
Kp=21
Kd=6+2*(rand-0.5)
lambda=20+2*(rand-0.5)

%   feedback(C*P,H)
%   parallel(sys1,sys2)

K2=parallel(Kp,(lambda*Kd*s)/(s+lambda));
K1=(1/((s+1)*(s-1)));

%FUNCIONES:
Gry=feedback(K1*K2,1)
figure(1)
step(Gry)

Gdy=-feedback(K1,K2)
figure(2)
step(20*Gdy)