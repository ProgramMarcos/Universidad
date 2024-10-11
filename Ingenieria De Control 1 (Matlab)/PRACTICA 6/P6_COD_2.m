%El siguiente código permite obtener la amplificación y el desfase fácilmente
%Hay que pinchar en un máximo de u(t) (curva color rojo) y a continuación en 
%   el máximo de y(t) (curva azul) inmediatamente siguiente.


figure(2)
w=w1; plot(t,u1,'r',t,y1,'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M1 = ymax/umax, phi1 = -(ty-tu)*w1*180/pi,

figure(3)
w=w2; plot(t,u2,'r',t,y2,'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M2 = ymax/umax, phi2 = -(ty-tu)*w2*180/pi,

figure(4)
w=w3; plot(t,u3,'r',t,y3,'b');
[hor,ver] = ginput(2); % pinchar aquí sobre max-u y sobre max-y
tu = hor(1); ty = hor(2);
umax = ver(1); ymax = ver(2);
M3 = ymax/umax, phi3 = -(ty-tu)*w3*180/pi,


% almacenar los tres experimentos
Mk = [M1, M2, M3];
phik = [phi1, phi2, phi3];
% convertir módulo y fase a parte real y parte imaginaria
rek = Mk .* cos(phik*pi/180);
imk = Mk .* sin(phik*pi/180);
wk = [w1, w2, w3];


wmin= w1/10; wmax=w3*10; % rango de frecuencias a estudiar
figure(5)
nyquist(G, {wmin, wmax});
hold on
plot(rek,imk,'r*','MarkerSize',10);
hold off;
axis([-5,2,-5,5]);


figure(6)
[mag,phase,frec]=bode(G,{wmin,wmax});
mag=mag(:); magdB= 20*log10(mag); % cálculo del módulo en dB
phase=phase(:); frec=frec(:);
MkdB = 20*log10(Mk); % cálculo del módulo en dB
subplot(211);
semilogx(frec,magdB,'b-',wk,MkdB,'r*');
grid;
subplot(212);
semilogx(frec,phase-360,'b-',wk,phik,'r*');
grid;