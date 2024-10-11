s=tf('s');
Ts=45;   
z= tf('z',Ts);
 

G= 0.75/(z-1);
 
H= 1/z;    
 
 
tp=[]; 
SO=[]; 
%como Kmax me salio de 1.33 hago el for hasta algo antes
%para sacar la k max debemos ver el valor de la ganancia cuando el LR corta
%al circulo unidad
for K=(0.1: 0.01 : 1.2),     
     info= stepinfo( feedback(K*G, H));     
     SO = [SO; info.Overshoot];     
     tp = [tp; info.PeakTime]; 
end; 
 

figure(2); 
plot(tp,SO,'*') 
grid; 
xlabel('Tp'); 
ylabel('SO');
