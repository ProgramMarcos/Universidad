clear all
close all
s=tf('s'); P= 1.3/(s+0.01); K= [0.1, 0.5, 1];
for k=1:3,
    C= K(k)*(s+0.2)/s; Gyd= feedback(P,C);Gud=-feedback(P*C,1);Gun=-feedback(C,P);
    figure(1)
    bodemag(Gyd); hold on;
    figure(2)
    bodemag(Gud); hold on;
    figure(3)
    bodemag(Gun); hold on;
end;