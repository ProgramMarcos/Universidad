clear all; clc;
z=tf('z');

G=(z-0.85)/((z-0.75)*(z-0.6)*(z-0.5));


uk1=0; uk2=0; uk3=0; % Inicialización
yk1=0; yk2=0; yk3=0;
T=0.25; N=40; % periodo aprox. T, N ciclos


plot(0,yk1,'oblue',0,uk1,'*red'); % gráfica
axis([0, N, -0.1, 3.6]); grid; hold on;
tic; k=1; % inicio temporizador
while k<=N,
    pause(T);
    uk= ( k>=10 ); %%%%'Lectura' Entrada
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    yk= ... % Cálculo Salida y(k)
    1.85*yk1 -1.125*yk2 + 0.225*yk3...
    +uk2 - 0.85*uk3 ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot(k,yk,'oblue',k,uk,'*red'); %'Escritura'Sal.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    k=k+1; % Actualizaciones Estados Internos
    yk3=yk2; yk2=yk1; yk1=yk;
    uk3=uk2; uk2=uk1; uk1=uk;
end;
toc % fin temporizador
hold off;