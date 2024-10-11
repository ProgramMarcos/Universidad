s = tf('s');
Ts=0.2; z = tf('z',Ts);
P = 6.4/(s+1)/(s+0.2);
G= c2d(P,Ts,'zoh');
D = 1; H = 0.03;
L = D*G*H;
T= feedback( D*G, H);

MFmin=50; Kmin=3; Kmax=10;
Wopt=0;
for K= Kmin: 0.1 :Kmax,
D=K; L=D*G*H; T=feedback(D*G, H);
[MG,MF,Wmg,Wmf]=margin(L);
if Wmf>Wopt & MF>MFmin & isstable(T),
Wopt= Wmf; Kopt=K;
end;
end;
Wopt, Kopt, Dopt=Kopt;
Lopt=Dopt*G*H; Topt= feedback(Dopt*G, H);
figure(1); nyquist(Lopt);
figure(2); bode(Lopt);
figure(3); step(0.03*Topt);