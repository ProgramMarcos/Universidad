clear all
clc
s=tf('s');
Ts=45;   
z= tf('z',Ts);

%******************%r1=1
Kg=0.75;
G= Kg/(z-1); 

H= 1/z; 

%****************%r2=3
tp=225; 

%*****************%r3=3
SO=0.02;

wd= pi/tp; 
sigma= -log(SO)/tp;


s1= -sigma+ i*wd ;
s2= conj(s1);
p1= exp(Ts*s1);
p2= conj(p1);

M = [ p1, 1;
      p2, 1];
N = [ evalfr( - (z^2*(z-1))/Kg, p1);
      evalfr(- (z^2*(z-1))/Kg, p2)];
X= inv(M)*N; 
X= real(X); 

A= X(1)
B= X(2)

D= (A*z+B)/z;
%*******************************RLOCUS
figure(1);
rlocus(D*G*H)

%*******************************STEP
figure(2);
step(feedback(D*G,H),1200)

%*****************************%FILTRO
wn = sqrt( sigma^2 + wd^2);
zeta= cos(atan(wd/sigma));
LC2s= wn^2/ (s^2 + 2*zeta*wn*s + wn^2);
LC2z= c2d( LC2s, Ts, 'zoh');
T= feedback(D*G,H);
F = LC2z/T; 
F=minreal(F); 
zpk(F),

figure(3);
step(T, F*T, 1200)