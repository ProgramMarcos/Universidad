clear all
close all
s=tf('s'); P= 1.3/(s+0.01); K= [0.1, 0.5, 1];
for k=1:3,
    C= K(k)*(s+0.2)/s; Gud=-feedback(P*C,1);
    bodemag(Gud); hold on;
end;