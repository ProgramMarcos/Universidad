clear all
close all
s = tf('s');
dni=21050001; % Incluir DNI alumno
rng(dni);
Kp= 0.2+0.04*(rand-0.5);
Ki=0.01;
Kd=4.32;
N=5+2*(rand-0.5);

P=1/(s^2);
Cpid=Kp+(Ki/s)+(Kd*s/(1+(s/N)));
Cpd=Kp+(Kd*s/(1+(s/N)));

GdoePID=-feedback(1,Cpid*P);
GdoePD=-feedback(1,Cpd*P);

GdiePID=-feedback(P,Cpid);
GdiePD=-feedback(P,Cpd);


t= (0:0.1:1000)';
figure(1)
lsim(GdoePID,t,t)

figure(2)
lsim(GdoePD,t,t)

figure(3)
lsim(GdiePID,t,t)

figure(4)
lsim(GdiePD,t,t)

einf3=-1/Ki

