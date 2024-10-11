s = tf('s');
dni =21050001 % números dni alumno
rng(dni);
p1=1+0.2*(rand-0.5)
G2a_LA=(s*(s+p1))/(s^3+p1*s^2+10*s+20);
sisotool