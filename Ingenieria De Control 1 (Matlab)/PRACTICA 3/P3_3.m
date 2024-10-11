%%%EJERCICIO 3%%%
clear all
close all
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
Gp = b/(s^2+a1*s+a2)
so = 0.01;
% Cálculo C = PI ideal con cancelación (método Pr2b)
delta = cos(atan(-pi/(log(so))));
alfa = (a1-sqrt((a1^2)-4*a2))/2
wn = (a1-alfa)/(delta*2)
ts = 4/(wn*delta)
Kp = (wn^2+2*alfa*delta*wn-a2)/b;
KI =(alfa*wn^2)/b;
C= (Kp*s+KI)/s
%Cálculo C2 = PI ideal sin cancelación (método general fijando SO, ts)
ts2 = 0.6
wn2=4/(ts2*delta)
alfa2 = a1-2*delta*wn2
Kp2 = (wn2^2+2*alfa2*delta*wn2-a2)/b;
KI2 =(alfa2*wn2^2)/b;
C2= (Kp2*s+KI2)/s
T1 =feedback(Gp*C,1);
T2= feedback(Gp*C2,1);

[numT1,denT1]=tfdata(T1,'v');
[R,P,K]=residue(numT1,denT1)


T11=R(1)/(s-P(1));
T12=R(2)/(s-P(2));
T13=R(3)/(s-P(3));

T14=T11+T12;

T1C=(T13+T14)
%[numT1C,denT1C]=tfdata(T1C,'v');
%[R,P,K]=residue(numT1C,denT1C)

ltiview(T1,T13)

hold on
pzmap(T1)
hold off

[numT2,denT2]=tfdata(T2,'v');
[R,P,K]=residue(numT2,denT2)


T21=R(1)/(s-P(1));
T22=R(2)/(s-P(2));
T23=R(3)/(s-P(3));
T24=T21+T22;

T2C=(T23+T14)
%[numT1C,denT1C]=tfdata(T1C,'v');
%[R,P,K]=residue(numT1C,denT1C)

ltiview(T2,T23)

hold on
pzmap(T2)
hold off





