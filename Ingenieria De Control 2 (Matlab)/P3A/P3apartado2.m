MFmin=60; %r2=3
MGmin=4.0; %r3=4

Kmin=0.1; Kmax=1;  % 0.1 0.7
Wopt=0; Kopt=0; K=0; 
Ts=45;
z=tf('z',Ts);
Gz=1.00/(z-1); %r1=2
D=K;

H=1/z;
T=feedback(D*Gz,H);
for K= Kmin:0.01:Kmax,
    D=K; L=D*Gz*H; T=feedback(D*Gz,H);
    [MG,MF,Wmg,Wmf]=margin(L)
    if Wmf>Wopt & MF>MFmin & MG>MGmin & isstable(T),
        Wopt=Wmf; Kopt=K;MFop=MF;MGop=MG;
    end;
end;
Wopt, Kopt, Dopt = Kopt;
Lopt = Dopt*Gz*H;
figure(1)
nyquist(Lopt);
figure(2)
step (Topt);

figure(3)
bode(Lopt);
Topt = feedback(Dopt*Gz, H);