s=tf('s'); Ts=0.2; P = 6.4/(s+1)/(s+0.2); %0.2 es el polo dominante
G= c2d(P,Ts,'zoh'); zpk(G) %nos sale p1=+0.961;p2=+0.8187; el más dominante es p1 por estar más próximo a 1

T1= feedback(0.1*G, 1);
T2= feedback(0.3*G, 1);
T3= feedback(1.0*G, 1);

figure(1)
step(T1,T2,T3,10); grid

figure(2)
rlocus(G)
return
%COMPROMISO SO Y tp
tp=[ ]; SO=[ ];
for K=(0.05: 0.01 : 0.75),
    info= stepinfo( feedback(K*G, 1));  %stepinfo no printea el step pero nos da los datos de so, tp, y(inf)...
    SO = [SO; info.Overshoot]; %como vemos se almacena la variable SO
    tp = [tp; info.PeakTime]; %lo mismo con el tp  
end;
figure(3); plot(tp,SO,'*'); grid;
xlabel('tp'); ylabel('SO');


%ajuste PI D(z)=(Az+B)/(z-1)
tp=4; SO=0.20; wd= pi/tp; sigma= -log(SO)/tp;
s1= -sigma+ i*wd; s2= conj(s1);
%z=exp(Ts*s)
%Z[1/(s+a)]=z/(z-p)  p=exp(-a*T)
p1= exp(Ts*s1); p2= conj(p1);  %Para que las raices sean estables su modulo debe ser menor que 1


%ajuste A,B
% 0=1+G*D=1+G*(Az+B)/(z-1)
%--->(Az+B)=(1-z)/G  para z=p1,p2
%p1*A+1*B=(1-z)/G  |z=p1
%p2*A+1*B=(1-z)/G  |z=p2
%    M  X=N
z= tf('z',Ts);
M = [ p1, 1;
p2, 1];
N = [ evalfr( (1-z)/G, p1 );
evalfr( (1-z)/G, p2 )];
X= inv(M)*N; X= real(X); A= X(1); B= X(2);

D= (A*z+B)/(z-1); T= feedback(D*G,1);
figure(4)
step( T, 15);grid

%***********************diseño del prefiltro

wn = sqrt( sigma^2 + wd^2 );
zeta= cos(atan(wd/sigma));
LC2s= wn^2/ (s^2 + 2*zeta*wn*s + wn^2 );
LC2z= c2d( LC2s, Ts, 'zoh' );

F = LC2z/T; F=minreal(F); zpk(F)

figure(5)
step( T, F*T, 15 ); grid