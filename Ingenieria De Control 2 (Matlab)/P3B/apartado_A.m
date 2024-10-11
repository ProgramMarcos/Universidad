s=tf('s');
Ts=45;   
z= tf('z',Ts);
%r1=1
Kg=0.75;
G= Kg/(z-1); 

H= 1/z; 

%r2=3
tp=225; 

%r3=3
SO=0.02;

wd= pi/tp; 
sigma= -log(SO)/tp;
s1= -sigma+ i*wd ;
s2= conj(s1);
p1= exp(Ts*s1);
p2= conj(p1);

figure(1)
rlocus(G*H)

%obtencion de A y B
z= tf('z',Ts);
M = [ p1, 1;
p2, 1];
N = [ evalfr( - (z^2*(z-1))/Kg, p1 );
evalfr( - (z^2*(z-1))/Kg, p2 )];
X= inv(M)*N; X= real(X); A= X(1); B= X(2);

%ENTONCES D=
D=(A*z+B)/z;
K=D;

figure(2)
step( feedback(K*G, H) )

 