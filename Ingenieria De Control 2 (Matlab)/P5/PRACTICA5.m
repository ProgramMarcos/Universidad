clear all
close all
s=tf('s');
%r1=1
Ts= 0.002
%r2=3 (0 < q < 30)
p3= 0.93; r= 0.95;


P=8620/(s+76.03)/(s-73.64);
%Apartado A

z=tf('z',Ts); 
G=c2d(P,Ts,'zoh');
zpk(G)
polosG=roots(G.den{1}); px= polosG(1)
zerosG=roots(G.num{1}); cx=zerosG(1)


SO=[ ]; Umax=[ ];   % <--- para el apartado 3
for q= 0:1:30; 
    u= r*cos(q*pi/180); v= r*sin(q*pi/180);

    H=(z-p3)* ((z-u)^2+v^2) /(z+1);
   
    N=[ evalfr(H,1); evalfr(H,px)];
    M=[ 1, 1; px, 1];
    AB=inv(M)*N;
    A=AB(1);
    B=AB(2);
    
    F=(A*z+B)/H;
    Di=feedback(F,-1)/G;
    
    
    D=minreal(Di, 0.001); 
    
    
    Fdg=feedback(D*G,1); 
    hold on
    figure(1)
    step(Fdg); 
    grid;

    info=stepinfo(Fdg);
    SO=[SO; info.Overshoot];

    Fd=feedback(D,G);
    t=(0:Ts:0.3);
    um=step(Fd,t);
    Umax=[Umax; max(abs(um))];
    
    if (max(abs(um))<4.5 & max(abs(um))>4.4 ) ; %apartado 5 al principio no ponemos este if, 
        H5=H;                                   %lo que hacemos es buscar el pto de umax que 
        A5=A;                                   %queremos y hacemos el if entre los puntos para que guarde los valores
        B5=B;
        F5=(A5*z+B5)/H5;
        Di5=feedback(F5,-1)/G;
        zpk(Di5),

        D5=minreal(Di5, 0.001); 
        zpk(D5),

        Fdg5=feedback(D5*G,1); 
        hold on
        figure(4)
        step(Fdg5); 
        grid;
        figure(5)
        rlocus(D5*G)
    end;
        

    
end;
%Apartado 3
figure(3); 
plot(Umax,SO,'*'); 
grid;
xlabel('Umax'); 
ylabel('SO');

%apartado 4
%me sale Umax=4.5 (de los valores aleatrorios r), si me voy a la gráfica
%saco que la U que me da menor SO y que es menor que Umax=4.5 es U=4.4 con
%SO=142.256. INTERACCION 18 FOR ENTRE 0 Y 17


