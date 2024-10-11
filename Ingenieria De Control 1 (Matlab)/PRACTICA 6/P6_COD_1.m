clear all; clc; format compact; s=tf('s');
% 1- SISTEMA, ENTRADAS y SALIDAS
c= 2; p=10;
G= (p/c)*(c-s)/(p+s); % sistema a estudiar
w1= 2; w2=5; w3=10; % frecuencias de prueba
tmax= 2*(2*pi/w1); % dos períodos de la frecuencia más baja
t=linspace(0,tmax,5000);
u1= sin(w1*t); u2= sin(w2*t); u3= sin(w3*t);
y1= lsim(G,u1,t); y2= lsim(G,u2,t); y3= lsim(G,u3,t);
figure(1)
subplot(311);plot(t,u1,'r',t,y1,'b');grid;
subplot(312);plot(t,u2,'r',t,y2,'b');grid;
subplot(313);plot(t,u3,'r',t,y3,'b');grid;



