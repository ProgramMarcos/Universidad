%%%% APARTADO A %%%%%%

s = tf('s');
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

gff11=C1*feedback(g1*g2,Kb)
gff12=feedback(g2,g1*Kb)
Gffw=[gff11 gff12]
g11=(feedback(C*(feedback(g1*g2,Kb)),1))
g12=(feedback(g2,g1*(-Kb-C),1))
Gw=[g11 g12]
%ENTRADA%
Td = -0.1+0.1*(rand-0.5);
t1 = (0:0.1:15)';
r1 = ones(size(t1));
t1 >= 5;
t1 < 10;
(t1 >= 5 & t1 < 10);
p1 = Td*(t1 >= 5 & t1 < 10);
u1 = [r1 p1];
figure(1)
lsim(Gw,u1,t1)
hold on
lsim(Gffw,u1,t1)
hold off


%%%% APARTADO B1 %%%%

g21=feedback(C*feedback(g1,g2*Kb),g2)
g22=feedback(g2*(-Kb-C)*g1,1,1) %poniendo el 1 como tercer factor hago realim positiva [feedback(sys1,sys2,1)=relim posit]----[feedback(sys1,sys2) ó feedback(sys1,sys2,-1)=realim neg]
GTm=[g21 g22]
figure(2)

lsim(GTm,u1,t1)

%%%% APARTADO B2 %%%%

figure(3)
lsim(Gw,u1,t1)
hold on
lsim(GTm,u1,t1)
hold off

%minreal(feedback(sys1,sys2,1))  me simplifica la ecuación si encuentra
%valores iguales en num y denomin