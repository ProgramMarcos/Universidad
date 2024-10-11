
load dat23
%dividimos en dos mitades para VALIDAR y ESTIMAR
ze=z23(1:500, 1:2);

zv=z23(501:1000, 1:2);


%ARMAX se compone de (entrada, [na, nb, nc, nk])

m1121 = armax(ze, [1 1 2 1]),
m2121 = armax(ze, [2 1 2 1]),
m3121 = armax(ze, [3 1 2 1]),

m1221 = armax(ze, [1 2 2 1]),
m2221 = armax(ze, [2 2 2 1]),
m3221 = armax(ze, [3 2 2 1]),

m1321 = armax(ze, [1 3 2 1]),
m2321 = armax(ze, [2 3 2 1]),
m3321 = armax(ze, [3 3 2 1]),

m1111 = armax(ze, [1 1 1 1]),
m2111 = armax(ze, [2 1 1 1]),
m3111 = armax(ze, [3 1 1 1]),

m1211 = armax(ze, [1 2 1 1]),
m2211 = armax(ze, [2 2 1 1]),
m3211 = armax(ze, [3 2 1 1]),

m1311 = armax(ze, [1 3 1 1]),
m2311 = armax(ze, [2 3 1 1]),
m3311 = armax(ze, [3 3 1 1]),

 %una vez ESTIMAMOS todas las posibles combinaciones, vamos a VALIDAR con la 
%segunda mitad de los datos y nos quedaremos con los que tienen mejor fit

compare(zv,m1121,m2121,m3121,m1221,m2221,m3221,m1321,m2321,m3321,m1111,m2111,m3111,m1211,m2211,m3211,m1311,m2311,m3311);

%cuando elegimos los que tienen el fit más alto (buscamos en la tabla de la
%gráfica) nos quedamos con el más sencillo, es decir,
%para ARMAX na+nb+nc+nk

%Proponemos el modelo final
%Podemos hacer los siguientes comandos entre dos
%de ellos para explicar que con menos parámetros tenemos un 'fit' muy
%parecido y
%que la respuesta a escalón es la misma. 

%en nuestro caso cogeriamos los 'mxxx' que nos interesaran

figure(4);
pzmap( m2211, m3311 )
figure(5);
step( m2211, m3311 )