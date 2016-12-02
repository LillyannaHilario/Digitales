%XXXXXXXXXXXXXXXXXXXXXXXXXXX Sampleo XXXXXXXXXXXXXXXXXXXXXXXXXX
M=16;
n=8;
test_data=('C:\Users\RamonV\Documents\Classes\Comunicaciones
Digitales\HW\Ondas continuas\1.wav');
%[d, f] = wavread(test_data);
%[data, fcar] = wavread(test_data, [1,0.01*f]);
[data, fcar] = wavread(test_data);              %44100 Hz esel
estandar ara sampleo de audio
plot(data);
x = [data]' ; % conversion del vector a columna
x=data;

                                                             s_data =
round((M-1)/2*(x + 1)) ;

%XXXXXXXXXXXXXXXXXXXX Cuantificacion EscalarXXXXXXXXXXXXXXXXXXXXXXXXXX
xq=floor((x+1)*2^(n-1));   %Signal is one of 2^n int values (0 to 2^n-1)
xq=xq/(2^(n-1));           %Signal is from 0 to 2 (quantized)
xq=xq-(2^(n)-1)/2^(n);     %Shift signal down (rounding)
plot(xq);
grid on;
zoom on
sound(xq, fcar);

%XXXXXXXXXXXXXXXXXXXXXXXXX Convertir a binario XXXXXXXXXXXXXXXXXXXXXXXX
y8 = typecast(xq(:), 'uint8');      %Uint8 con typecast devuelve los
16 bits completos en dos segmentos de 8 bits (3 y 232) manteniendo así
su valor original (3 * 256 + 232 = 1000).
ybin = dec2bin(y8, 8) - '0';        %Produce una representación
binaria con al menos n bits.
disp(ybin);
plot(xq);

fprintf('\n\n');

%XXXXXXXXXXXXXXXXXXXXXXXXX Modulacion QAM XXXXXXXXXXXXXXXXXXXXXXXX
p = qammod(ybin,M) ;

                                           ybin=s_data;

bp=.1;
RR=real(p);                        %Devuelve la parte real de los
elementos de la matriz compleja p.
II=imag(p);                        %Parte imaginaria del número complejo
sp=bp*2;                           %Periodo del simbolo
sr=1/sp;                           %Tasa de simbolos
f=sr*2;
t=sp/100:sp/100:sp;                %Muestreo de la senal
ss=length(t);                      %Tamano de t
m=[];
for(k=1:1:length(RR))              %Limita la senal al tamano de la entrada
    yr=RR(k)*cos(2*pi*f*t);        % inphase or real component
    yim=II(k)*sin(2*pi*f*t);       % Quadrature or imagenary component
    y=yr+yim;
    m=[m y];
end
tt=sp/100:sp/100:sp*length(RR);
plot(tt,m);
title('Forma de onda de QAM-16');
xlabel('tiempo(sec)');
ylabel('amplitude(volt)');
zoom on

y = awgn(p,10);
