clear all;close all; clc; format compact
Mc=1; Mb=1; Bc=1; Bb=0.25; L=1; g=9.81; x10=-1;
%%%%%%%%%%%%%%%
%K= 1*[1,1,1,1]; %K=ganancias
%K';
U=1000, %U=saturacion
%%%%%%%%%%%%%%%

SOthmax= (5*pi)/180;
SOxmax=0.05;
%%Matrices del modelo del sistema
A =[0          0                1       0;
    0          0                0       1;
    0     (g*Mb/Mc)          (-Bc/Mc)    0;
    0 (((-g*Mb)/Mc*L)-(g/L)) (Bc/Mc*L)  -Bb];
B= [0;
    0;
    (1/Mc);
    (-1/Mc*L)];



%Polos=[-2.0,-2.0,-1.6,-1.7]
Polos=[-1.0,-2.0,-3.0,-4.0]
K=acker(A,B,Polos);


sim('grua2');

subplot(311); plot(t,xc,'b');grid; title('posicion carro m');
hold on
plot([0,25],[SOxmax,SOxmax],'r')
plot([0,25],[0.1,0.1],'r')
plot([0,25],[-SOxmax,-SOxmax],'r')

subplot(312); plot(t,th,'b');grid; title('angulo rad');
hold on
plot([0,25],[SOthmax,SOthmax],'r')
plot([0,25],[-SOthmax,-SOthmax],'r')

subplot(313); plot(t,u,'b');grid; title('actuacion Nw');
hold off