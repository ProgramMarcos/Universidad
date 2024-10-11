%APARTADO 2)
s = tf('s');
dni=21050001;
rng(dni);

p1=1+0.2*(rand-0.5);
p2=11+0.2*(rand-0.5);
c=10+0.2*(rand-0.5);

A=p1*p2/c
B=p1*p2
N=p1+p2-A
kp=B/N
kd=(A-kp)/N

T=((p1*p2/c)*(s+c))/((s+p1)*(s+p2))


figure(2)
step(T)

