clc;clear all;close all;
fs_max=1*10^9;
T_max=100*10^-3;
N=1;
tao=T_max/N;
t_max=0:1/fs_max:T_max;
t1_max=0:1/fs_max:tao;
f_low = 10*10^3;
f_high = 60*10^3;
s=chirp(t1_max,f_low,tao,f_high);
% s=cos(2*pi*0.5*10^6*t1_max);
x=[s zeros(1,(length(s) - 1)*(N-1))];
x_xing=conj(x);
td_ini=2.3524e-05;
fd_ini=44.4524;
y=recreation(x, td_ini, fd_ini, fs_max);

NFFT=2^20;
fs=1*10^6;
td_max=3.5*10^-5;
fd_max=2000;
x_xing_sample=resample(x_xing,fs,fs_max);
y_sample=resample(y,fs,fs_max);
L=length(x_xing_sample);
% NFFT=2^nextpow2(L);
delta_t=1/fs;
delta_f=fs/NFFT;
f=fs/2*linspace(0,1,NFFT/2+1);

% y_tao=recreation(x, 0, 0, fs);
% r=x_xing.*y_tao;
% R=fft(r,NFFT)/L;
% plot(f,2*abs(R(1:NFFT/2+1)));

M=td_max/delta_t+1;
CAF=zeros(NFFT/2+1,M);
td_range=linspace(-td_max,0,M);
tic;
for i=1:M
   td=td_range(i);
   y_tao=recreation(y_sample, td, 0, fs);
   r=x_xing_sample.*y_tao;
   R=fft(r,NFFT)/L;
   CAF(:,i)=2*abs(R(1:NFFT/2+1));
end
toc;
% mesh(-td_range,f,CAF);
tic;
CAF_s=CAF(1:fd_max+1,:);
f_s=f(1:fd_max+1);
% mesh(-td_range,f_s,CAF_s);
[c1,l1]=max(CAF_s);
[c2,l2]=max(c1);
r=l1(l2);
c=l2;
ele_max=CAF(r,c);
td_N=length(c1)-l2+1;
fd_N=l1(l2);
td_comp=(td_N-1)/fs
fd_comp=(fd_N-1)*delta_f
% choose_ambiguity_mat=[CAF_s(r-1,c+1) CAF_s(r-1,c) CAF_s(r-1,c-1);
%     CAF_s(r,c+1) CAF_s(r,c) CAF_s(r,c-1);
%     CAF_s(r+1,c+1) CAF_s(r+1,c) CAF_s(r+1,c-1)];
choose_ambiguity_mat=CAF_s(r-1:r+1,c-1:c+1);
[correct_td,correct_fd] = quadratic_surface_fitting(choose_ambiguity_mat, delta_t, delta_f, td_comp, fd_comp)
toc;
