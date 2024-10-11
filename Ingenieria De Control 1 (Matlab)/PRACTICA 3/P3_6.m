%%%EJERCICIO 6%%%

s = tf('s');

SO=0.1;
tp=0.5;
yinf=0.01;

S=cos(atan(-pi/log(SO)))
wn=pi/(tp*sqrt(1-S^2))

K=1/yinf
M=K/wn^2
kp=1/(wn^2*M)
B=2*S*M*wn


G6=(1/M)/(s^2+(B/M)*s+(K/M))
ltiview(G6)