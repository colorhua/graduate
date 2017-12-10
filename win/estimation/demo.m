clear all;clc;close all;
% f0 = 1*10^9;
% fs = 10*10^9;
% L = 500;
% t = (0:L)*1/fs;
% NFFT = 2^nextpow2(L);
% s = cos(2*pi*f0*t);
% S = fft(s,NFFT)/NFFT;
% k = 0:NFFT-1;
% f = k*fs/NFFT;
% figure(1)
% plot(t,s);
% figure(2)
% plot(f,abs(S),'b');
fs=1*10^5;L=5000;t=(0:L-1)*1/fs;T=L/4;
s2_ori=exp(j*2*pi*0*t).*(t<=T/fs);
plot(t,s2_ori);