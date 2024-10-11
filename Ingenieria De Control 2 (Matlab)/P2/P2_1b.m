Tfin=30; dtmax=0.001;
A0=1; f0=1/20; T= 0.001;
a=1; b=1;
sim('P2model');
figure(1); subplot(121);
plot(t,y1,'blue-'); grid
subplot(122)
plot(t,u1,'red-'); grid

%segunda parte
Tfin=30; dtmax=0.001;
A0=1; f0=1/20; a=1; b=1; T= 0.2;
sim('P2model');
figure(1); subplot(121);
plot(t,y1,'b',t,y2,'r'); grid
subplot(122)
plot(t,u1,'b',t,u2,'r'); grid

Max_Err = max( abs(y1-y2) )
   
%Max_Err < 0.16