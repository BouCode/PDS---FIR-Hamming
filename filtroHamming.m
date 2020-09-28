clc all; close all; clear all;

tic
[data, Fs] = audioread('sound1.wav');
T = 1 / Fs; 
fc = 2000;
fc1 = 2000;
fc2 = 3000;
M = 10;
N = length(data);
fp = Fs * [0:N-1]/N;
t = [0:N-1]' * T;    
FC = fc/(Fs/2);
FC1 = fc1/(Fs/2);
FC2 = fc2/(Fs/2);

y = fft (data);
y = fftshift (y);
y = abs (y);
ny = y/max(y);

figure (1);
subplot (211);
plot (t, data);
title ('Audio');
xlabel ('Tiempo (s)')
grid;

subplot (212);
plot (fp(1:(N/2)), y(N/2:end-1));  
title ('x[n]');
xlabel ('Frecuencia (Hz)')
grid;

b_l=fir1(M, FC, "low");
b_u=fir1(M, FC, "high");
b_p=fir1(M, [FC1 FC2], "bandpass");

figure (2);
subplot (311);
plot (b_l);
title ('Filtro basa bajo')

subplot (312);
plot (b_u);
title ('Filtro pasa alto')

subplot (313);
plot (b_p);
title ('Filtro pasa banda')

z1 = conv (data, b_l);
z2 = conv (data, b_u);
z3 = conv (data, b_p);

xf1 = filter (b_l, 1, data);
xf2 = filter (b_u, 1, data);
xf3 = filter (b_p, 1, data);

s1 = fft (b_l,N);
s1 = fftshift (s1);
s1 = abs (s1);
ns1 = s1/max(s1);

p1 = fft (xf1, N);
p1 = fftshift (p1);
p1 = abs (p1);
np1 = p1/max(p1);

s2 = fft (b_u,N);
s2 = fftshift (s2);
s2 = abs (s2);
ns2 = s2/max(s2);

p2 = fft (xf2, N);
p2 = fftshift (p2);
p2 = abs (p2);
np2 = p2/max(p2);

s3 = fft (b_p,N);
s3 = fftshift (s3);
s3 = abs (s3);
ns3 = s3/max(s3);

p3 = fft (xf3, N);
p3 = fftshift (p3);
p3 = abs (p3);
np3 = p3/max(p3);

figure (3)

subplot (221);
plot (t, data);
title ('Frecuencia');

subplot (222);
plot (t, xf1);
title ('Señal filtrada');
xlabel('tiempo');
ylabel ('Amplitud');

subplot (223);
plot (fp(1:(N/2)), ny(N/2:end -1));
hold on;
plot (fp(1:(N/2)), ns1(N/2:end -1),'color', 'r');
hold off;
title ('Pasa bajo: Frecuencia');
grid on;

subplot (224);
plot (fp(1:(N/2)), np1(N/2:end -1))
title ('Pasa bajo: Señal filtrada');
xlabel('Hz');
ylabel('Amplitud')
grid on;

figure (4);

subplot (221);
plot (t, data);
title ('Frecuencia');

subplot (222);
plot (t, xf2);
title ('Señal filtrada');
xlabel('tiempo');
ylabel ('Amplitud');

subplot (223);
plot (fp(1:(N/2)), ny(N/2:end -1))
hold on;
plot (fp(1:(N/2)), ns2(N/2:end -1), 'color', 'r')
hold off;
title ('Pasa alto: Frecuencia');
grid on;

subplot (224);
plot (fp(1:(N/2)),np2(N/2:end - 1))
title ('Pasa alto: Señal filtrada');
xlabel('Hz');
ylabel('Amplitud')
grid on;

figure (5);

subplot (221);
plot (t, data);
title ('Frecuencia');

subplot (222);
plot (t, xf3);
title ('Señal filtrada');
xlabel('tiempo');
ylabel ('Amplitud');

subplot (223);
plot (fp(1:(N/2)),ny(N/2:end - 1));
hold on;
plot (fp(1:(N/2)),ns3(N/2:end - 1),'color', 'r');
hold off;
title ('Pasa banda: Frecuencia');
grid on;

subplot (224);
plot (fp(1:(N/2)),np3(N/2:end - 1))
title ('Pasa banda: Señal filtrada');
xlabel('Hz');
ylabel('Amplitud')
grid on;

figure (6);

subplot (311);
plot (t, data);
hold on;
plot (t, z1 (1:length(z1)-M));
hold off;
title ('Convolución: Pasa bajo')
grid;

subplot (312);
plot (t, data);
hold on;
plot (t, z2 (1:length(z2)-M));
hold off;
title ('Convolución: Pasa alta')
grid;

subplot (313);
plot (t, data);
hold on;
plot (t, z3(1:length(z3)-M));
hold off;
title ('Convolución: Pasa banda')
grid;

figure (7);
freqz (b_l, 1, N)

figure (8);
freqz (b_u, 1, N)

figure (9);
freqz (b_p, 1, N)

#audiowrite ('Ruisenior.wav', data, Fs)
#audiowrite ('RuiseniorPasaBajo.wav', z1, Fs)
#audiowrite ('RuiseniorPasaAlto.wav', z2, Fs)
#audiowrite ('RuiseniorPasaBanda.wav', z3, Fs)
toc;
#{
fprintf ('Audio Original\n')
sound (data)
fprintf ('Audio Filtro Pasa Baja\n')
sound (z1)
fprintf ('Audio Filtro Pasa Alta\n')
sound (z2)
fprintf ('Audio Filtro Pasa Banda\n')
sound (z3)
}#
#PORFIN
