clear all; close all;
s=tf('s');
dni=21050001; % Números del DNI del alumno
rng(dni);
D0=0.5+0.4*(rand-0.5); % Amplitud de la señal do(t)
K=4*pi^2*[0.01, 0.1, 1]; % Valores de ganancia del controlador C(s)=K(s+1)/s
f_i=[0.1 1 10]; % Valores de frecuencia Hz
w = 2*pi*f_i;
P=1/s;
for k=1:3,
    C=(K(k)*(s+1))/s;
    Gde=-feedback(1,C*P);
    figure(1)
    bodemag(Gde); hold on;
end;
for k=1:3,
    C=(K(k)*(s+1))/s;
    Gdu=-feedback(C,P);
    figure(2)
    bodemag(Gdu); hold on;
end;