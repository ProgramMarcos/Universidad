clear all

%                               -1- Planta muestreada
s=tf('s'); P=8620/(s+76.03)/(s-73.64);
Ts=0.001; z=tf('z',Ts); 
G= c2d(P,Ts,'zoh');
zpk(G)

%0.0043086 (z+0.9992)          
%--------------------          --> ZERO EN -1,
% (z-1.076) (z-0.9268)             UN POLO ESTABLE, UN POLO INEST

%PARA OBTENER POLO INEST
polosG=roots(G.den{1}); px= polosG(1)

%                               -2- Lazo Cerrado Deseado.
%el lazo cerrado deseado, proponemos:
%       (Az+B) (z+1)
% F = ---------------------
%      (z-p3)[(z-u)^2 + v^2]

%Usar un tercer orden da más flexibilidad que un segundo orden. Explicar por qué este
%formato de F(z) cumple ya las restricciones de causalidad y robustez
%a) grRel(F)>=1  (2polos-1zero)
%b)F(1)=1
%c)F(px)=1
%d)F(cx)=0  cx=-0.9992 (es inestable porque aproximamos a -1)

p3= 0.93; r= 0.95; q= 8; % modulo r, fase q, polos complejos
u= r*cos(q*pi/180); v= r*sin(q*pi/180);

H=(z-p3)*[(z-u)^2+v^2] /(z+1)
evalfr(H,px)

H=(z-p3)*[(z-u)^2+v^2] /(z+1); A=0.0235; B=-0.022765;
F= (A*z+B)/H; Di= feedback(F,-1)/G;
zpk(Di)  %reguldor inicial

D= minreal(Di, 0.001); zpk(D)
F2= feedback(D*G,1);
figure(1)
step(F2); grid;

%Tiene un tiempo de establecimiento de 7 centésimas, pero una sobreoscilación del 115%.
%Rastreando la causa, nos encontramos un cero muy lento, -B/A=0.9687 (>>rlocus(D*G))
figure(2)
rlocus(D*G)

%La sobreoscilación podría eliminarse con un prefiltro, aunque el prefiltro solo es posible
%aplicarlo a las señales de referencia. Las perturbaciones, como Vy, Vu
%no son accesibles y no pueden prefiltrarse, por tanto las perturbaciones pueden generar
%transitorios con SO=115%. Este tipo de problemas con la SO son inevitables, cuando
%trabajamos con plantas inestables.