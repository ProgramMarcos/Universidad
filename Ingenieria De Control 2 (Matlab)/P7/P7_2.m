clear all; clc;
s=tf('s');
z=tf('z')

Kp=2.5;Ki=3.5;;Kd=0.2;Tf=0.05;
C=Kp+Ki/s+Kd*s/(1+Tf*s);

t=linspace(0,2,1000);
y=step(C,t);grid
figure(1);plot(t,y,'red-');

Ts=0.03;
Czi=c2d(Ki/s,Ts,'tustin')
Czd=Kd*((z-1)/(Ts*z))/(1+Tf*((z-1)/(Ts*z)));

hold on
step(Kp+Czi+Czd,2);grid;
axis([0,max(t),0,max(y)])
hold off


