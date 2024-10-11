clear all;
s=tf('s'); 


%r1= 1
hu=0.02;
hy=0.06;
%r2= 3
%r3= 3

Tf=0.003; 
P= 8620/(s+76)/(s-73.6); 
t=(0: 0.001: 0.4); 
tsopt=0.2; SOopt=10000;


for k=0.01: 0.005: 0.07,   %barrido k %inicialmente ata 0.05, pero aumentamos a 0.07
    for c= 14.5: 0.05: 15.5,     % barrido c 
          C= k*(s+c)*(s+76)/s/(1+s*Tf);        
          if isstable(feedback(C*P,1)), 
 
           Yy=step( hy*feedback(1,C*P), t); 
           Uy=step(-hy*feedback(C, P),  t);            
           Yu=step( hu*feedback(P, C),  t);  
           Uu=step(-hu*feedback(C*P,1), t); 
 
           %Para ver os datos de SO e ts, en realidade xa se ven despois do
           %bucle if que os igualei sin punto e coma para que aparezcan
           
           info= stepinfo(Uu,t);   
           SO= info.Overshoot;  
           ts= info.SettlingTime; 
 
           if SO<SOopt & ts<tsopt  & max(abs(Uy))<0.5 & max(abs(Yu))<0.5 & max(abs(Uu))<0.5 & max(abs(Yy))<0.5,      
               tsopt=ts
               SOopt=SO 
               kopt=k 
               copt=c   
           end;       
          end; 
    end; 
end; 

C= kopt*(s+copt)*(s+76)/s/(1+s*Tf);

%DISCRETIZACIÓN
[MG,MF,wf,wc]=margin(C*P)
%Obtemos que 
  %wc=142rad/seg

%En función de r3
Ts = 0.30/wc;
tdig=(0:Ts: 0.4); 

D= c2d(C,Ts,'tustin') 
G= c2d(P,Ts,'zoh')
Yy=step( hy*feedback(1,D*G),tdig); 
Uy=step(-hy*feedback(D,G),tdig);
Yu=step( hu*feedback(G,D),tdig);  
Uu=step(-hu*feedback(D*G,1),tdig); 
 

figure(2);
subplot(221); 
stairs(tdig,Yy);
grid; 
title('Yy'); 

subplot(222); 
stairs(tdig,Uy);
grid; 
title('Uy');

subplot(223); 
stairs(tdig,Yu);
grid; 
title('Yu'); 

subplot(224); 
stairs(tdig,Uu);
grid; 
title('Uu'); 

%Para ver os datos de SO e ts
info= stepinfo(Uu);  
SO= info.Overshoot;
ts= info.SettlingTime;