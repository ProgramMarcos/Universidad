clear all
close all
s=tf('s'); 
G=(s^2+0.2*s+2)/((s+0.2)*(s^2+0.2*s+3));
C=0.2*(1+s/0.2)/s;
bode(G*C)
