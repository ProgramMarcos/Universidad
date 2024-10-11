
clear all
s = tf('s');
dni=21050001; % Incluir números DNI alumno
rng(dni);
dv = 0.05;
R = 2.0;
L = 0.5;
Km = 0.1;
Kb = 0.1+2*dv*(rand-0.5);
Kf = 0.2;
J = 0.02;
b =Km/L/J;
a1=(L*Kf+R*J)/L/J;
a2= (R*Kf+Km*Kb)/L/J;
P = b/(s^2+a1*s+a2)
einf = 0.03+0.04*(rand-0.5)
Kp = -1+1/einf;
K = Kp/dcgain(P);
C=(1+(s/1.65))/(1+(s/0.5117))
KP = K*P
KPC=KP*C
