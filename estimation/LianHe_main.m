clc;clear all;close all;
%% 生成原始信号
fs_a=1*10^9;
fs_d=200*10^3;
td_ini=19.87*10^-6;
fd_ini=19.08;
T=0.1;
N=2;
tao=0.9*T;
t_a=0:1/fs_a:T;
t_d=0:1/fs_d:T;
tao_a=0:1/fs_a:tao;
tao_d=0:1/fs_d:tao;
B=10*10^3;
f_low_a=0;
f_high_a=f_low_a+B;
k=B/tao;
s_a=exp(1j*2*pi*(f_low_a*tao_a+1/2*k*tao_a.^2));
s_a=[s_a zeros(1,int32(fs_a*(T-tao)))];
y_a1=s_a;
y_a2=recreation(s_a, td_ini, fd_ini, fs_a);
SNR=15;
%% 信号采样
y_d1=downsample(y_a1,fs_a/fs_d);
y_d2=downsample(y_a2,fs_a/fs_d);
%% 构造噪声低通滤波器
Bn=50*10^3;
fn_h=Bn;
Wn=fn_h/(fs_d/2);
[b,a]=butter(8,Wn,'low');
%% 用wgn加噪声
y_d1_power=sum(abs(y_d1).^2)/length(y_d1);
y_d2_power=sum(abs(y_d2).^2)/length(y_d2);
NOISE1_power=y_d1_power / ( 10^(SNR/10) );
NOISE2_power=y_d2_power / ( 10^(SNR/10) );
NOISE1=wgn(1,length(y_d1),10*log10(NOISE1_power),'complex');
NOISE2=wgn(1,length(y_d2),10*log10(NOISE2_power),'complex');
%% 构造带限噪声
NOISE_band1=filter(b,a,NOISE1);
NOISE_band2=filter(b,a,NOISE2);
NOISE_band1=NOISE_band1*sqrt(NOISE1_power/(std(NOISE_band1)^2));
NOISE_band2=NOISE_band2*sqrt(NOISE2_power/(std(NOISE_band2)^2));
y_dn1=y_d1+NOISE_band1;
y_dn2=y_d2+NOISE_band2;
%% 构造原始信号低通滤波器
Wn_low=(f_high_a+80)/fs_d;
b_y=fir1(96,Wn_low,'low');
y_dn1_band=filter(b_y,1,y_dn1);
y_dn2_band=filter(b_y,1,y_dn2);
%% 不加噪声
% y_dn1_band=y_d1;
% y_dn2_band=y_d2;
y_dn1_band_xing=conj(y_dn1_band);
delta_t=1/fs_d;
Nf=2^nextpow2(fs_d/0.1);
delta_f=fs_d/Nf;
td_max=40*10^-6;
fd_max=40;
N=fd_max/0.1;
L=length(y_dn1_band_xing);
M=int32(2*td_max/delta_t+1);
CAF=zeros(2*N,M);
td_range=-td_max:delta_t:td_max;
for i=1:M
   td=td_range(i);
   y_tao=recreation(y_dn2_band, td, 0, fs_d);
   r=y_dn1_band_xing.*y_tao;
   R=fft(r,Nf)/L;
   R=fftshift(R);
   CAF(:,i)=abs(R(Nf/2-N+1:Nf/2+N));
end
% mesh(CAF);
% f=fs_d/2*linspace(0,1,Nf/2+1);
% CAF_s=CAF(1:fd_max+1,:);
% f_s=f(1:fd_max+1);
[c1,l1]=max(CAF);
[c2,l2]=max(c1);
r=l1(l2);
c=l2;
ele_max=CAF(r,c);
% td_N=length(c1)-l2+1;
% fd_N=l1(l2);
td_comp=(td_max/delta_t+1-c)/fs_d
fd_comp=(r-N)*delta_f
choose_ambiguity_mat=CAF(r-1:r+1,c-1:c+1);
[correct_td,correct_fd] = quadratic_surface_fitting(choose_ambiguity_mat, delta_t, delta_f, td_comp, fd_comp)
