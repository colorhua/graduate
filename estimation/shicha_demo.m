clc;clear all;close all;
%% 生成原始信号
fs_a=1*10^9;
fs_d=200*10^3;
td_ini=19.87*10^-3;
fd_ini=20;
T=0.1+td_ini;
tao=0.1;
t_a=0:1/fs_a:T;
t_d=0:1/fs_d:T;
tao_a=0:1/fs_a:tao;
tao_d=0:1/fs_d:tao;
B=10*10^3;
f_low_a=0;
f_high_a=f_low_a+B;
k=B/tao;
s_a=exp(1j*2*pi*(f_low_a*tao_a+1/2*k*tao_a.^2));
s_ak=[s_a zeros(1,int32(fs_a*(T-tao)))];
y_a1=s_a;
y_a2=recreation(s_ak, td_ini, fd_ini, fs_a);
y_d1=downsample(y_a1,fs_a/fs_d);
y_d2=downsample(y_a2,fs_a/fs_d);
L=length(y_d1);
Nf=2^nextpow2(2*L-1);
delta_f=fs_d/Nf;
Y_d1=fft(y_d1,Nf);
Y_d2=fft(y_d2,Nf);
f=fs_d/2*linspace(0,1,Nf/2+1);
subplot(3,1,1)
plot(f,abs(Y_d1(1:Nf/2+1)));
subplot(3,1,2)
plot(f,abs(Y_d2(1:Nf/2+1)));
y_d2k=[zeros(1,int32(fs_d*(T-tao))) y_d2];
y2_xz=y_d2k.*exp(-1j*2*pi*fd_ini*t_d);
y2_xz=y2_xz(int32(fs_d*(T-tao))+1:length(y2_xz));
Y2_xz=fft(y2_xz,Nf);
subplot(3,1,3)
plot(f,abs(Y2_xz(1:Nf/2+1)));
r=xcorr(y2_xz,y_d1);
[m,index]=max(abs(r));
