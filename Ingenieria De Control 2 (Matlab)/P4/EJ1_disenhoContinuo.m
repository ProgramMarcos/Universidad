clear all;
s=tf('s'); 


%r1= 1
hu=0.02;
hy=0.06;
%r2= 3
%r3= 3

tsopt=0.2; SOopt=10000;  %si me sale r2=1o r2=2 ponemos tsopt muy grande y la SOopt especificada

Tf=0.003; 
P= 8620/(s+76)/(s-73.6); 
t=(0: 0.001: 0.4);


for k=0.01: 0.01: 0.07, %barrido k
    for c= 27.9: 0.01: 28.5, % barrido c
        C= k*(s+c)*(s+76)/s/(1+s*Tf);
       
        if isstable(feedback(C*P,1)),
            Yy=step( hy*feedback(1,C*P), t); 
            Uy=step(-hy*feedback(C, P), t);
            Yu=step( hu*feedback(P, C), t); 
            Uu=step(-hu*feedback(C*P,1), t);
            
            info= stepinfo(Uu,t); 
            SO= info.Overshoot
            ts= info.SettlingTime;
           
            if SO<SOopt & ts<tsopt  & max(abs(Uy))<0.5 & max(abs(Yu))<0.5 & max(abs(Uu))<0.5 & max(abs(Yy))<0.5,
                tsopt=ts 
                kopt=k
                copt=c
                SOop = SO
            end;
        end;
    end;
end;


C= kopt*(s+copt)*(s+76)/s/(1+s*Tf);
Yy=step( hy*feedback(1,C*P),t); 
Uy=step(-hy*feedback(C,P),t); 
Yu=step( hu*feedback(P,C), t);  
Uu=step(-hu*feedback(C*P,1),t); 

figure(1);  
subplot(221);  
plot(t,Yy); 
grid; 
title('Yy');
         
subplot(222); 
plot(t,Uy); 
grid; 
title('Uy');           
            
subplot(223);
plot(t,Yu); 
grid; 
title('Yu');          
            
subplot(224); 
plot(t,Uu); 
grid; 
title('Uu'); 