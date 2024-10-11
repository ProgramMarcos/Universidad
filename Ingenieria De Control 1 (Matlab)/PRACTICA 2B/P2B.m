s = tf('s');
%APARTADO 1A)

%  CONSTANTES  %
b=10;
a1=14;
a2=47;
SO=0.01;
TITA=atan(-pi/log(SO));
Am=cos(TITA)
ALFA=(a1-sqrt((a1*a1)-(4*a2)))/2
Wn=(a1-ALFA)/(2*Am)
ts=4/(Am*Wn)
Ki=(Wn*Wn*ALFA)/b
Kp=Ki/ALFA
%Kp2=(Wn*Wn+2*Am*Wn*ALFA-a2)/b ---> COMPROBACION
P=b/(s^2+a1*s+a2)
C2=(Kp*s+Ki)/s

%APARTADO 1B)

%   COMPROBACIONES  %
b>0
a1>0
a2>0
a1*a1>=4*a2
0<ALFA<=a1

%%%% CODIGO PRÁCTICA 2A  %%%%
R = 2.0; % Ohms
L = 0.5; % Henrys
Km = 0.1; Kb = 0.1; % torque y emf constantes
Kf = 0.2; % Nms
J = 0.02; % kg.m^2/s^2
Kff = 4.1;
C1 = 4.1;
K=5;
C =K/s;
dni=21050001;
rng(dni);
g1=Km/(L*s+R);
g2=1/(J*s+Kf);

g11=(feedback(C2*(feedback(g1*g2,Kb)),1));
g12=(feedback(g2,g1*(-Kb-C2),1));

g11a=(feedback(C*(feedback(g1*g2,Kb)),1));
g12a=(feedback(g2,g1*(-Kb-C),1));


g21=feedback(C2*feedback(g1,g2*Kb),g2);
g22=feedback(g2*(-Kb-C2)*g1,1,1);

g21a=feedback(C*feedback(g1,g2*Kb),g2);
g22a=feedback(g2*(-Kb-C)*g1,1,1);


G2=[g11 g12; g21 g22]
G=[g11a g12a; g21a g22a];

%ENTRADA%
Td = -0.1+0.1*(rand-0.5);
t1 = (0:0.1:15)';
r1 = ones(size(t1));
t1 >= 5;
t1 < 10;
(t1 >= 5 & t1 < 10);
p1 = Td*(t1 >= 5 & t1 < 10);
u1 = [r1 p1];

%APARTADO 1C)
figure(1)
lsim(G2,u1,t1)
hold on
lsim(G,u1,t1)
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%APARTADO 2)

%El dni ya está definido arriba
p1=1+0.2*(rand-0.5);
p2=11+0.2*(rand-0.5);
c=10+0.2*(rand-0.5);

A=p1*p2/c
B=p1*p2
N=p1+p2-A
kp=B/N
kd=(A-kp)/N

C2b=((kp+kd*N)*s+kp*N)/(N+s)
T=((p1*p2/c)*(s+c))/((s+p1)*(s+p2))


figure(2)
step(T)

