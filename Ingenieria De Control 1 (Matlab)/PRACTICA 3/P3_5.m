%%%EJERCICIO 5%%%

s = tf('s');
dni=21050001;
rng(dni);

td=5570+60*(rand-0.5)
xtd=0.5

pc=(log(1/(1-xtd)))/td

Gc=pc/(s+pc)
ltiview(Gc)
