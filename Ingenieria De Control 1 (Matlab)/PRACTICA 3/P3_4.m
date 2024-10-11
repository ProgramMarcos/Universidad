%%%EJERCICIO 4%%%

s = tf('s');

kp=2;
kd=1;
E=0.1;
G=kp+((kd*s)/(1+E*s));

ltiview(G)