% clc;clear all;close all;
% % fs=1*10^6;
% % T=0.001;
% % N=1;
% % tao=T/N;
% % t=0:1/fs:T;
% % t1=0:1/fs:tao;
% % f_low = 100*10^3;
% % f_high = 300*10^3;
% % s=chirp(t1,f_low,tao,f_high);
% % s=[s zeros(1,fs*T+1-length(s))];
% % L=length(s);
% % % NFFT=2^nextpow2(L);
% % NFFT=2^20;
% % delta_f=fs/NFFT;
% % S=fft(s,NFFT)/L;
% % f=fs/2*linspace(0,1,NFFT/2+1);
% % figure(1)
% % plot(t,s);
% % figure(2)
% % plot(f,2*abs(S(1:NFFT/2+1)));
% % 
% % % td=4*10^-5;
% % % fd=1*10^6;
% % td=0;
% % fd=50*10^3;
% % s_td_fd = recreation(s, td, fd, fs);
% % S_td_fd=fft(s_td_fd,NFFT)/L;
% % figure(3)
% % plot(t,abs(s_td_fd));
% % figure(4)
% % plot(f,2*abs(S_td_fd(1:NFFT/2+1)));
% % 
% % r=conj(s).*s_td_fd;
% % figure(5)
% % plot(t,abs(r));
% % R=fft(r,NFFT)/L;
% % figure(6)
% % plot(f,2*abs(R(1:NFFT/2+1)));
% 
% f_zai=1*10^9;
% fs_a=1*10^9;
% fs_d=1*10^6;
% % f_center=100*10^3;
% T=100*10^-3;
% t_a=0:1/fs_a:T;
% t_d=0:1/fs_d:T;
% B=100*10^3;
% f_low_a=50*10^3;
% f_high_a=f_low_a+B;
% s_a=chirp(t_a,f_low_a,T,f_high_a);
% SNR=20;
% s_d=resample(s_a,fs_d,fs_a);
% %% 用自己的函数加噪声
% NOISE = noisegen(s_d,SNR);
% fn_h=400*10^3;
% Wn=fn_h/(fs_d/2);
% [b,a]=butter(12,Wn);
% % s_d_n=filter(b,a,s_d_n);
% NOISE_band=filter(b,a,NOISE);
% s_d_n=s_d+NOISE_band;
% snr=SNR_singlech(s_d,s_d_n);
% 
% %% 用awgn加噪声 加带限噪声有问题！！！
% % s_d_n=awgn(s_d,SNR);
% % fn_h=200*10^3;
% % Wn=fn_h/(fs_d/2);
% % [b,a]=butter(8,Wn);
% % s_d_n=filter(b,a,s_d_n);
% % snr=SNR_singlech(s_d,s_d_n);
% %% 观察频谱
% L=length(s_d_n);
% NFFT=2^nextpow2(2*L-1);
% delta_f=fs_d/NFFT;
% S_d=fft(s_d_n,NFFT)/L;
% % NOISE_fft=fft(NOISE,NFFT)/L;
% % NOISE_band_fft=fft(NOISE_band,NFFT)/L;
% f=fs_d/2*linspace(0,1,NFFT/2+1);
% % figure(1)
% % plot(f,abs(NOISE_fft(1:NFFT/2+1)));
% % figure(2)
% % plot(f,abs(NOISE_band_fft(1:NFFT/2+1)));
% figure(3)
% plot(f,abs(S_d(1:NFFT/2+1)));
% 
clc;clear all;close all;
%% 生成原始信号
fs_a=1*10^9;
fs_d=1*10^6;
T=100*10^-3;
N=2;
tao=T/N;
t_a=0:1/fs_a:T;
t_d=0:1/fs_d:T;
tao_a=0:1/fs_a:tao;
tao_d=0:1/fs_d:tao;
B=100*10^3;
f_low_a=50*10^3;
f_high_a=f_low_a+B;
k=B/tao;
s_a=exp(1j*2*pi*(f_low_a*tao_a+1/2*k*tao_a.^2));
s_a=[s_a zeros(1,(length(s_a) - 1)*(N-1))];
y_a1=s_a;
td_ini=300*10^-9;
fd_ini=25*10^3;
y_a2=recreation(s_a, td_ini, fd_ini, fs_a);
y_d1=resample(y_a1,fs_d,fs_a);
y_d2=resample(y_a2,fs_d,fs_a);
L=length(y_d1);
Nf=2^nextpow2(2*L-1);
% delta_f=fs_d/Nf;
y_d1=[y_d1 zeros(1,Nf-L)];
y_d2=[y_d2 zeros(1,Nf-L)];
Y_d1=fft(y_d1,Nf)/Nf;
Y_d2=fft(y_d2,Nf)/Nf;
f=fs_d/2*linspace(0,1,Nf/2+1);
figure(1)
plot(f,abs(Y_d1(1:Nf/2+1)));
figure(2)
plot(f,abs(Y_d2(1:Nf/2+1)));
% Y_dn2=fft(y_dn2,Nf)/Nf;
% Y_dn1=fftshift(Y_dn1);
% Y_dn2=fftshift(Y_dn2);