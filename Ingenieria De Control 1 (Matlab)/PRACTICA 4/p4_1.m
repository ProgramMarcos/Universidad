clear all
close all
s = tf('s');
dni=21050001;
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
so = 0.01;
% Cálculo C = PI ideal con cancelación (método Pr2b)
delta = cos(atan(-pi/(log(so))));
alfa = (a1-sqrt((a1^2)-4*a2))/2
wn = (a1-alfa)/(delta*2)
ts = 4/(wn*delta)
Kp = (wn^2+2*alfa*delta*wn-a2)/b;
KI =(alfa*wn^2)/b;
C= (Kp*s+KI)/s
T = feedback(P*C,1);

%%%  CONTINUACIÓN DEL CÓDIGO  %%%

Kp2=(KI/a1)-(a2/b);
C2=(Kp2*s+KI)/s
T2 = feedback(P*C2,1);
figure(1)
step(T2)
figure(2)
hold on
pzmap(T2)
hold off

Kp3=KI/a1-a2/b-rand;
C3=(Kp3*s+KI)/s
T3= feedback(P*C3,1);
figure(3)
step(T3)
figure(4)
hold on
pzmap(T3)
hold off

%%%  APARTADO B  %%%
C4=4
T4= feedback(P*C4,1);
figure(5)
step(T,T4)


