%%%EJERCICIO 1%%%
clear all
s = tf('s');
dni=21050001;
rng(dni);
c=1+0.2*(rand-0.5)

G1=minreal((10*((s/c)+1))/((s+1)*(s+10)))
[numG1,denG1]=tfdata(G1,'v');
[R,P,K]=residue(numG1,denG1)

G11=R(1)/(s-P(1))
G12=R(2)/(s-P(2))

G1c=G11+G12

ltiview(G1,G11,G12,G1c)






