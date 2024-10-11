clear all;
s=tf('s'); 

Tobj= 288/(s^2+24*s+288); 
figure(1); step(Tobj); %lazo cerrado deseado
P= 2873000/(s+333.3)/(s+76.03)/(s-73.64); A= 0.0106; B=0.0236;
K= (A*s+B)*(s+76.03)/s; LC=feedback(K*P,1); 

zpk(LC) %lazo cerrado obtenido

%        30454 (s+76.03) (s+2.226)
%  ------------------------------------------
%  (s+235.8) (s+76.03) (s^2 + 23.84s + 287.5)

F= 2.22/(s+2.22); %f=x/(s+2.22) y sacamos x con f(0)=1 -->x=2.22

figure(2); step( F* feedback(K*P, 1) ); grid

[MG,MF,wf,wc]=margin(K*P) %nos sale un MF pequeño aprox 24

T=[0.15,0.50]/wc  %0.0029    0.0096

Ts=0.003; G= c2d(P,Ts,'zoh'); D= c2d(K,Ts,'tustin');
Fz= c2d(F,Ts,'tustin'); figure(3); step(Fz*feedback(D*G,1));

LCz= feedback(D*G,1); 

figure(4); step(LCz, Fz*LCz); grid  %sin prefiltro SO=300%

P= 8620/(s+76)/(s-73.6); 
A= 0.0106; B=0.0236; 
Tf=0.003;

C=(A*s+B)*(s+76)/s/(1+s*Tf); 
hu=0.06; hy=0.02; t=(0: 0.001: 0.4);

Yy=step( hy*feedback(1,C*P),t); 
Uy=step(-hy*feedback(C,P),t);
Yu=step( hu*feedback(P,C), t); 
Uu=step(-hu*feedback(C*P,1),t);

figure(1);
subplot(221); plot(t,Yy); grid; title('Yy');
subplot(222); plot(t,Uy); grid; title('Uy');
subplot(223); plot(t,Yu); grid; title('Yu');
subplot(224); plot(t,Uu); grid; title('Uu');