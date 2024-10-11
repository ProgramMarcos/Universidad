clear all; clc; format compact; s=tf('s');
% 1- SISTEMA, ENTRADAS y SALIDAS
dni=21050001;
rng(dni);
c=0.1;
p=1.5+rand-0.5;
G= (p^2/c)*(c+s)/(p+s)^2

bode(G)

w1=0.24;
w2=1.1565;
w3=15.8;


tmax= 2*(2*pi/w1); % dos períodos de la frecuencia más baja
t=linspace(0,tmax,5000);
u1= sin(w1*t); u2= sin(w2*t); u3= sin(w3*t);
y1= lsim(G,u1,t); y2= lsim(G,u2,t); y3= lsim(G,u3,t);
figure(1)
subplot(311);plot(t,u1,'r',t,y1,'b');grid;
subplot(312);plot(t,u2,'r',t,y2,'b');grid;
subplot(313);plot(t,u3,'r',t,y3,'b');grid;


figure(2)
w=w1; plot(t,u1,'r',t,y1,'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M1 = ymax/umax, phi1 = -(ty-tu)*w1*180/pi,

figure(3)
w=w2; plot(t,u2,'r',t,y2,'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M2 = ymax/umax, phi2 = -(ty-tu)*w2*180/pi,

figure(4)
w=w3; plot(t(1:200),u3(1:200),'r',t(1:200),y3(1:200),'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M3 = ymax/umax, phi3 = -(ty-tu)*w3*180/pi,


% almacenar los tres experimentos
Mk = [M1, M2, M3];
phik = [phi1, phi2, phi3];
% convertir módulo y fase a parte real y parte imaginaria
rek = Mk .* cos(phik*pi/180);
imk = Mk .* sin(phik*pi/180);
wk = [w1, w2, w3];


wmin= w1/10; wmax=w3*10; % rango de frecuencias a estudiar
figure(5)
nyquist(G, {wmin, wmax});
hold on
plot(rek,imk,'r*','MarkerSize',10);
hold off;
axis([-5,2,-5,5]);


figure(6)
[mag,phase,frec]=bode(G,{wmin,wmax});
mag=mag(:); magdB= 20*log10(mag); % cálculo del módulo en dB
phase=phase(:); frec=frec(:);
MkdB = 20*log10(Mk); % cálculo del módulo en dB
subplot(211);
semilogx(frec,magdB,'b-',wk,MkdB,'r*');
grid;
subplot(212);
semilogx(frec,phase,'b-',wk,phik,'r*');
grid;

