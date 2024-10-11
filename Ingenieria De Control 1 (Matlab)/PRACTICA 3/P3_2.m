%%%EJERCICIO 2%%%

clear all
s = tf('s');
dni=21050001;
rng(dni);
a=20+20*(rand-0.5)
n2=a^2
d2=s*((s+a)^2)
Y=minreal(n2/d2)
[numY,denY]=tfdata(Y,'v');
[R,P,K]=residue(numY,denY)
Y1=R(1)/(s-P(1))
Y2=R(2)/(s-P(2))^2
Y3=R(3)/(s-P(3))
Yc=minreal(Y1+Y2+Y3)

ltiview(Y,Yc,Y1,Y2,Y3)

t=0:0.1:10;
yt=1-(1+a*t).*exp(-a*t)