clear all
close all

A = [ 1 -1.1 0.3]; % na=2: nº de coeficientes del denominador
B = [ 0 3 1.5]; % nb=2/nk=1: nº coef.num./retardo uy (nº ceros)
m0 = idpoly( A,B );

%>> m0 % Modelo B(q)/A(q)
%Discrete-time IDPOLY model: A(q)y(t) = B(q)u(t) + e(t)
%A(q) = 1 - 1.1 q^-1 + 0.3 q^-2
%B(q) = 3 q^-1 + 1.5 q^-2

L= 250;
u = idinput( 2*L, 'rbs');
e = 0.25* randn(2*L, 1);
y = sim(m0, [u, e]);
z=[y,u];
figure(1); idplot(z);

% Estimacion modelos arx (primeros L datos)
% [na, nb, nk]
% na = nº de coef. "a" en A
% nb = nº de coef. "b" en B
% nk = "retardo" E/S= nº de ceros iniciales en B
m221 = arx( z(1:L, 1:2), [2 2 1]);
m222 = arx( z(1:L, 1:2), [2 2 2]);
m111 = arx( z(1:L, 1:2), [1 1 1]);

%{
Los modelos estimados salen:

>> m221
    Discrete-time IDPOLY model: A(q)y(t) = B(q)u(t) + e(t)
    A(q) = 1 - 1.105 q^-1 + 0.3034 q^-2
    B(q) = 3.005 q^-1 + 1.493 q^-2
    Loss function 0.0564641 and FPE 0.058271
>> m222
    Discrete-time IDPOLY model: A(q)y(t) = B(q)u(t) + e(t)
    A(q) = 1 - 1.143 q^-1 + 0.35 q^-2
    B(q) = 1.318 q^-2 + 0.1124 q^-3
    Loss function 8.93407 and FPE 9.21996
>> m111
    Discrete-time IDPOLY model: A(q)y(t) = B(q)u(t) + e(t)
    A(q) = 1 - 0.8961 q^-1
    B(q) = 3.026 q^-1
    Loss function 5.77859 and FPE 5.87104


Como estamos en simulación, la validez de los 3 modelos la podemos deducir comparando
sus polinomios B(q)/A(q) con los polinomios originales B(q)/A(q) creados al principio.

Pero en una identificación práctica real, el modelo original no existiría. Para elegir
el mejor de los modelos estimados podríamos fijarnos en los indicadores de error (Loss function,
Final Prediction Error FPE); cuanto más pequeños, más exacto es el modelo.
%}

figure(2); % Validacion (ultimos L datos)
compare( z((L+1):(2*L), 1:2), m221,m222,m111);

%porcentaje de fit m221 (95.24%). El mejor modelo es m221.

%Por ejemplo si aumentamos en uno el grado de numerador y denominador,
%estimamos un ARX con esos ordenes (m331) y lo comparamos con el m221:
m331 = arx( z(1:L, 1:2), [3 3 1]);
figure(3); compare( z((L+1):(2*L),1:2), m221, m331 );

%Vemos que la mejora del fit es insignificante, a costa de dos parámetros más, que parecen
%innecesarios. Podemos ver la distribución de raíces:
figure(4); pzmap( m221, m331 )

%El modelo m331 tiene un polo y cero adicional que son cancelables, generando m221, más
%simple. La equivalencia entre ambos se confirma también con las respuestas a escalón, que
%son indistinguibles.
figure(5); step( m221, m331 )