clear all
close all

MFmin=60; %r2=3
MGmin=4; %r3=4
Kmin=0.1; Kmax=10;  
Cmin=0.1; Cmax=13;    
Ts=45;
z=tf('z',Ts);
Gz=1.00/(z-1); %r1=2
Wopt=0;
H=1/z;

for K= Kmin:0.1:Kmax,
    for C= Cmin:1:Cmax,
    D=K*(z-C)/z; L=D*Gz*H; T=feedback(D*Gz, H);
    [MG,MF,Wmg,Wmf]=margin(L);
        if Wmf>Wopt & MF>MFmin & MG>MGmin & isstable(T),
            Wopt=Wmf; Kopt=K; Copt=C;MFop=MF;MGop=MG;
        end;
    end;
end;

Wopt, Kopt, Copt,MGop,MFop, Dopt = Kopt*(z-Copt)/(z-1);
Lopt = Dopt*Gz*H;
Topt = feedback(Dopt*Gz, H);
figure(1)
nyquist(Lopt);
figure(2)
step (Topt);

figure(3)
bode(Lopt);