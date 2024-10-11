clear all;
s=tf('s'); 
DNI=21050001; % números DNI alumno
rng(DNI);
einf=0.02+0.02*(rand-0.5)
MFd=(50+20*(rand-0.5))*pi/180% MF deseado en radianes
MFdGR=(50+20*(rand-0.5))
wc=100;
P=5.263/s^2;
%continuar código
ka=1/einf
K=ka/5.236
s=j*wc;
P_frec=evalfr(P,s)
a=real((-cos(MFd)-j*sin(MFd))/(K*P_frec))
b=imag((-cos(MFd)-j*sin(MFd))/(K*P_frec))
wz=(b*wc)/((a^2+b^2)-a)
wp=(b*wc)/(a-1)
s=tf('s'); 
C=(1+(s/wz))/(1+(s/wp))

margin(K*P*C)