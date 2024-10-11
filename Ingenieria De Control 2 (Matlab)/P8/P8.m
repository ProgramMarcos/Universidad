clear all;close all; clc; format compact
Mc=1; Mb=1; Bc=1; Bb=0.25; L=1; g=9.81; x10=-1;

dni=21050001;
rng(dni);
U=6+8*(rand-0.5);

p1=-1+i;
p2=-1-i;
p3=-5;
p4=-10;
%fs=1;   %<5
%%Matrices del modelo del sistema
A =[0          0                1       0;
    0          0                0       1;
    0     (g*Mb/Mc)          (-Bc/Mc)    0;
    0 (((-g*Mb)/Mc*L)-(g/L)) (Bc/Mc*L)  -Bb];
B= [0;
    0;
    (1/Mc);
    (-1/Mc*L)];
tsfinal=1000;
for fs=0.01:0.05:1  %ELLA DICE ENTRE 1 Y 5, PERO TIENES QUE TANTEAR
    plc_des=fs*[p1,p2,p3,p4];
    K=acker(A,B,plc_des);
    thmax=0.25;  %DEPENDE DE TU GRUPO DE PRACTICAS
    sim('grua2');
    for pos=1:1:15000
        if xc(pos)<-0.05 | xc(pos)>0.05
            ts=t(pos);
        end
    end
    if max(abs(th))<=thmax & ts<tsfinal
        thfinal=max(abs(th));
        tsfinal=ts;
        plcfinal=plc_des;
        Kfinal=K;
    end
end

K=Kfinal;
sim('grua2'); 
subplot(311); plot(t,xc,'b');grid; title('posicion carro m');
subplot(312); plot(t,th,'b');grid; title('angulo rad');
subplot(313); plot(t,u,'b');grid; title('actuacion Nw');



