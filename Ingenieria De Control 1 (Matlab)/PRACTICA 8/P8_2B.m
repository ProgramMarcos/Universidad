clear all; close all;
s=tf('s');
dni=21050001; % Números del DNI del alumno
rng(dni);
D0=0.5+0.4*(rand-0.5); % Amplitud de la señal do(t)
K=4*pi^2*[0.01, 0.1, 1]; % Valores de ganancia del controlador C(s)=K(s+1)/s
f_i=[0.1 1 10]; % Valores de frecuencia Hz
P=1/s;

for k=1:3,
    C=(K(k)*(s+1))/s;
    "Para K="+K(k)
    Gde=-feedback(1,C*P);
    Gdu=-feedback(C,P);
    for f=1:3,
        "FRECUENCIA="+f_i(f)
        w = 2*pi*f_i(f);
        s=j*w;
        Gde_frec=evalfr(Gde,s);
        modulo_Gde=abs(Gde_frec);
        E=modulo_Gde*D0
        Gdu_frec=evalfr(Gdu,s);
        modulo_Gdu=abs(Gdu_frec);
        U=modulo_Gdu*D0
        
    end;
end;
