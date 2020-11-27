close all
clear
clc
%%
N  = 512;
fe = 50e6;

t = (0:N-1) * 1/fe; % time

%% input signal 
f0 = 5e6; % transmit frequency
x  = cos(2*pi*f0.*t); 

%% output signal
y  = rand*cos(2*pi*f0.*t) + ... % fundamental
    rand*cos(2*pi*2*f0.*t) + ... % second harmonic
    rand*cos(2*pi*3*f0.*t); % third harmonic 

%% Volterra modelisation
ordre   = 3;
memoire = 3;

x_model = Volterra(x, y, ordre, memoire);
%% Figure
figure,
plot(t,x,t,x_model)

freq = (0:N-1)/N * fe;
figure,
plot(freq,20*log10(abs(fft(x))),freq,20*log10(abs(fft(y))),freq,20*log10(abs(fft(x_model))))