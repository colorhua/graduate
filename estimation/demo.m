clc;clear all;close all;
fs=1*10^6;
T=0.001;
N=1;
tao=T/N;
t=0:1/fs:T;
t1=0:1/fs:tao;
f_low = 100*10^3;
f_high = 300*10^3;
s=chirp(t1,f_low,tao,f_high);
s=[s zeros(1,fs*T+1-length(s))];
L=length(s);
% NFFT=2^nextpow2(L);
NFFT=2^20;
delta_f=fs/NFFT;
S=fft(s,NFFT)/L;
f=fs/2*linspace(0,1,NFFT/2+1);
figure(1)
plot(t,s);
figure(2)
plot(f,2*abs(S(1:NFFT/2+1)));

% td=4*10^-5;
% fd=1*10^6;
td=0;
fd=50*10^3;
s_td_fd = recreation(s, td, fd, fs);
S_td_fd=fft(s_td_fd,NFFT)/L;
figure(3)
plot(t,abs(s_td_fd));
figure(4)
plot(f,2*abs(S_td_fd(1:NFFT/2+1)));

r=conj(s).*s_td_fd;
figure(5)
plot(t,abs(r));
R=fft(r,NFFT)/L;
figure(6)
plot(f,2*abs(R(1:NFFT/2+1)));
