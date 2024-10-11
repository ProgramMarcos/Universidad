%ejercicio 1
%como hacerlo: Copiar código, cambiar DNI y abrir el archivo simulink "P2lab.mdl"
%simular codigo hasta justo antes de "ejercicio 2" y sacar de la gáfica lo
%que pide. OJO, QUE LAS LETRAS a,b CAMBIAN EN FUNCIÓN DEL r1 QUE SALGA. no
%fijarse en el periodo T, en el ej 1 no importa

clear all; clc; format compact
s=tf('s')
DNI= ; 
rng(DNI)
r1=randi(4)
r2=randi(4)
r3=randi(4)

Tfin=30;  
dtmax=0.001; 
A0=1;  
f0=1/20;  
a=1; b=2/3;       
T= 0.737      % <<<<<<<< periodo T
sim('P2lab');

k=(b*s+1)/(a*s+1)

figure(1); subplot(121);
plot(t,y1,'b'); grid
title('y_1(t) (azul)')
subplot(122) 
plot(t,u1,'b'); grid 
title('u_1(t) (azul)')


%ejetrcicio 2
%pones el T de arriba como T=0.25, o lo que te mande el profesor
%en función del r2 que te salga tienes que hacer algo distinto.
%si te sale hacia adelante tienes que cambiar en K(s) la letra s por (z-1)/T
%si te sale hacia atrás tienes que cambiar en K(s) la letra s por (z-1)/(T*z)
%si te sale trapezoidal (Tustin) tienes que cambiar en K(s) la letra s por
%[2*(z-1)/T*(z+1)]

%una vez simplifiques eso ya tendrás D(z), pues K(z)=D(z) 
%vas al archivo simulink "P2lab.mdl" debes modificar la caja
%correspondiente (segundo y tercer diagrama la caja que realimenta), con lo
%obtenido
%ejecutas y ves lo obtenido.
%ahora nos fijaremos en el r3 obtenido para ver el error máximo que podemos
%permitir y debemos ajustar T hasta que el error sea igual (o lo más
%parecido posible) al permitido
%una vez ajustado anotamos el T=Tc y el error=e y calculamos la
%sobreoscilacion (SO) de la linea roja


figure(2); subplot(121);
plot(t,y2,'r', t,y1,'b'); grid
title('y_2(t) (roja),y_1(t) (blue)');
subplot(122) 
plot(t,u2,'r',t,u1,'b' ); grid
title('u_2(t) (roja),u_1(t) (blue)');


Err_Abs= abs(y1-y2);
Max_Error= max( Err_Abs)

%el ejercicio 3 es puramente teórico
