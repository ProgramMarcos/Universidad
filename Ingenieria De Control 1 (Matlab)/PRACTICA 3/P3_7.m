%%%EJERCICIO 7%%%

clear all;
s = tf('s');
dni=21050001; 
rng(dni);
p1=1+0.2*(rand-0.5);
p2=11+0.2*(rand-0.5);
c2=10+0.2*(rand-0.5);

T=((p1*p2/c2)*(s+c2))/((s+p1)*(s+p2))
Tr=p1/(s+p1)  %calculado en el trabajo previo

ltiview(T,Tr)
