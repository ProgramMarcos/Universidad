clear all; clc; format compact; s=tf('s');
T=0.625;

w=2*pi/T
R=0.9797;
L=0.1012;
G=1/(R+L*s);


tmax=2.5; % dos períodos de la frecuencia más baja
t=linspace(0,tmax,5000);
u1= 5*sin(w*t);
y1= lsim(G,u1,t);
figure(1)
plot(t,u1,'r',t,y1,'b');grid;

figure(2)
plot(t,u1,'r',t,y1,'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M1 = ymax/umax, phi1 = -(ty-tu)*w*180/pi,
