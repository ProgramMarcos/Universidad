clear all
close all
clc
load dat23
%Tenemos 1000 muestras, guardamos cada mitad en una variable 
%Utilizamos la 1ª mitad 1:500 y 1:2 para ESTIMAR
ze=z23(1:500, 1:2);
%Utilizamos la 2ª mitad 501:1000 y 1:2 para VALIDAR
zv=z23(501:1000, 1:2);

%ARX se compone de (entrada, [na, nb, nk])

m110 = arx(ze, [1 1 0]),
m210 = arx(ze, [2 1 0]),
m310 = arx(ze, [3 1 0]),

m120 = arx(ze, [1 2 0]),
m220 = arx(ze, [2 2 0]),
m320 = arx(ze, [3 2 0]),

m130 = arx(ze, [1 3 0]),
m230 = arx(ze, [2 3 0]),
m330 = arx(ze, [3 3 0]),

m111 = arx(ze, [1 1 1]),
m211 = arx(ze, [2 1 1]),
m311 = arx(ze, [3 1 1]),

m121 = arx(ze, [1 2 1]),
m221 = arx(ze, [2 2 1]),
m321 = arx(ze, [3 2 1]),

m131 = arx(ze, [1 3 1]),
m231 = arx(ze, [2 3 1]),
m331 = arx(ze, [3 3 1]),
 %una vez ESTIMAMOS todas las posibles combinaciones, vamos a VALIDAR con la 
%segunda mitad de los datos y nos quedaremos con los que tienen mejor fit
 

compare(zv, m110, m210, m310, m120, m220, m320, m130, m230, m330, m111, m211, m311, m121, m221, m321, m131, m231, m331);
%cuando elegimos los que tienen el fit más alto (buscamos en la tabla de la
%gráfica) nos quedamos con el más sencillo, es decir, para ARX na+nb


%Por ejemplo si nos sale m211 e m111. 4 frente a 3,nos quedamos con m111

%Proponemos el modelo final
%Podemos hacer los siguientes comandos entre dos
%de ellos para explicar que con menos parámetros tenemos un 'fit' muy
%parecido y
%que la respuesta a escalón es la misma. 

%en nuestro caso cogeriamos los 'mxxx' que nos interesaran

figure(4);
pzmap( m221, m331 )
figure(5);
step( m221, m331 )