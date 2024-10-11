% Las constantes físicas:
R = 2.0; % Ohms
L = 0.5; % Henrys
Km = 0.1; Kb = 0.1; % torque and back emf constants
Kf = 0.2; % Nms
J = 0.02; % kg.m^2/s^2
% Ejemplos-Formatos FT/VE, FT<->VE con g=Km/(L*s+R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Los modelos, tanto en formato ‘tf’ (y zpk), ‘ss’, son:
n = Km
d = [L R]
g = tf(n,d) % Definición 1 en función de transferencia
g = zpk(g) % Definición en formato cero/polo/ganancia
s = tf('s'); % Definición 2 en función de transferencia
gg = Km/(L*s+R)
gg = zpk(gg)
[nn,dd] = tfdata(gg,'v') % Acceso a datos del numerador y denominador ('v'=formato vectorial)
h = ss(g) % Definición en espacio de estados
ggg = tf(h)
% Realización mínima
gt = (L*s+R)/s
gs = g*gt % Funciones en serie
gs = minreal(g*gt) % Simplifica elementos iguales en el num y den
gpar = g+gt % Funciones en paralelo
%Cambios formatos
[A,B,C,D] = tf2ss(n,d) % De función de transferencia a espacio de estados
[nnn,ddd] = ss2tf(A,B,C,D) % De espacio de estados a FT
[z,p,k] = tf2zpk(n,d) % De función de transferencia a cero/polo/ganancia
% Cálculo lazo cerrado. feedback
h = 1;
g_lc = feedback(g,h)
g_lc1 = feedback(g,h,-1) %Equivalente a la anterior.
 %Signo de realimentación negativo
g_lc2 = feedback(g,h,1) % Distinta. Realimentación con signo positivo
% Ejemplo - Composición de entradas.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t1 = (0:0.1:1)'
r1 = ones(size(t1))
t1 >= 0.5
t1 < 0.7
(t1 >= 0.5 & t1 < 0.7)
p1 = 0.3*(t1 >= 0.5 & t1 < 0.7)
u1 = [r1 p1]
figure(1)
plot(t1,u1)
% Ejemplo - Simulación %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
lsim(g_lc,r1,t1) % Simulación de sistemas lineales