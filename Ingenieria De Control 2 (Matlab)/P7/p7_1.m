clear all; clc;

z=tf('z');
Ga = -42/(z-0.5);
Gb = 50/(z-0.6);
Gc = -8/(z-0.75);

Gbc= Gb+Gc;

uk1=0; uk2=0; uk3=0; % Inicialización
yAk1=0;
yBCk1=0; yBCk2=0;

T=0.25; N=40; % periodo aprox. T, N ciclos 
plot(0,0,'oblue',0,uk1,'*red'); % gráfica 
axis([0, N, -0.1, 3*3.6]); grid; hold on;
tic; k=1; % inicio temporizador 
while k<=N,
 pause(T);
 uk= ( k>=10 ); %%%%'Lectura' Entrada , es un buleano, cuando k>=10 vale 1
 % GA
 yAk=0.5*yAk1-42*uk1;
 yAk1=yAk;
 % GBC
 yBCk=1.35*yBCk1-0.45*yBCk2+42*uk1-32.7*uk2;
 yBCk2=yBCk1; yBCk1=yBCk;
 % G
 yk= yAk + yBCk; 
 %%%%%%%%
 plot(k,yk,'oblue',k,uk,'*red'); %'Escritura'Sal.
 %%%%%%
 k=k+1; % Actualizaciones Estados Internos
 uk3=uk2; uk2=uk1; uk1=uk;
end;
toc % fin temporizador
hold off;