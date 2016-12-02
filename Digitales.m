%XXXXXXXXXXXXXXXXXXXXXXXXXXX Sampleo XXXXXXXXXXXXXXXXXXXXXXXXXX

n=8;
M=256;
test_data=('C:\Users\RamonV\Documents\Classes\Comunicaciones
Digitales\HW\Ondas continuas\1.wav');
% [d, f] = wavread(test_data);
% [data, fcar] = wavread(test_data, [1,0.01*f]);
[data, fcar] = wavread(test_data);              %44100 Hz esel
estandar ara sampleo de audio

x = [data]' ; % conversion del vector a columna
x=data;

plot( s_data);
%XXXXXXXXXXXXXXXXXXXX Cuantificacion EscalarXXXXXXXXXXXXXXXXXXXXXXXXXX
xq=floor((x+1)*2^(n-1));   %Signal is one of 2^n int values (0 to 2^n-1)
xq=xq/(2^(n-1));           %Signal is from 0 to 2 (quantized)
xq=xq-(2^(n)-1)/2^(n);     %Shift signal down (rounding)

N = length(data);
t = linspace(0, N/fcar, N)
plot(t, xq)
grid on;
zoom on
ylabel('amplitud(volt)');
xlabel(' tiempo(sec)');
title('Cuantificacion Escalar');
%sound(xq, fcar);

%XXXXXXXXXXXXXXXXXXXXXXXXX Convertir a binario XXXXXXXXXXXXXXXXXXXXXXXX
y8 = typecast(xq(:), 'uint8');      %Uint8 con typecast devuelve los
16 bits completos en dos segmentos de 8 bits (3 y 232) manteniendo así
su valor original (3 * 256 + 232 = 1000).
ybin = dec2bin(y8, 8) - '0';        %Produce una representación
binaria con al menos n bits.
%disp(ybin);
%plot(xq);

fprintf('\n\n');
% x=ybin;
%
% bp=00000.1;                                                    % bit period
% bit=[];
% for n=1:1:length(x)
%     if x(n)==1;
%        se=ones(1,100);
%     else x(n)==0;
%         se=zeros(1,100);
%     end
%      bit=[bit se];
%
% end
% t1=bp/100:bp/100:100*length(x)*(bp/100);
% plot(t1,bit,'lineWidth',2.5);grid on;
% axis([ 0 bp*length(x) -.5 1.5]);
% ylabel('amplitude(volt)');
% xlabel(' time(sec)');
% title('transmitting information as digital signal');
%XXXXXXXXXXXXXXXXXXXXXXXXX Modulacion QAM XXXXXXXXXXXXXXXXXXXXXXXX

p = qammod(ybin,M) ;
% bp=.1;
% RR=real(p);                        %Devuelve la parte real de los
elementos de la matriz compleja p.
% II=imag(p);                        %Parte imaginaria del número complejo
% sp=bp*2;                           %Periodo del simbolo
% sr=1/sp;                           %Tasa de simbolos
% f=sr*2;
% t=sp/100:sp/100:sp;                %Muestreo de la senal
% ss=length(t);                      %Tamano de t
% m=[];
% for(k=1:1:length(RR))              %Limita la senal al tamano de la entrada
%     yr=RR(k)*cos(2*pi*f*t);        % inphase or real component
%     yim=II(k)*sin(2*pi*f*t);       % Quadrature or imagenary component
%     y=yr+yim;
%     m=[m y];
% end
% tt=sp/100:sp/100:sp*length(RR);
% plot(tt,m);
% title('Forma de onda de QAM-16');
% xlabel('tiempo(sec)');
% ylabel('amplitude(volt)');
% zoom on
%XXXXXXXXXXXXXXXXXXXXXX Ruido Blanco Gaussiano XXXXXXXXXXXXXXXXXXX
y = awgn(p,10);

%XXXXXXXXXXXXXXXXXXXXXXXXXXX Modulacion QAM XXXXXXXXXXXXXXXXXXXXXX
z = qamdemod(y, M);
z1 = (z - (M-1)/2) / M ;
sound(z1, fcar);

