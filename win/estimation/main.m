close all;clear all;clc;
fs=1*10^5;L=5000;t=(0:L-1)*1/fs;T=L/4;
fd=20.365;tao=-0.118459;tao_max=0.3;fd_max=fd*2;
% s1_ori=cos(2*pi*f0*t).*(t<=T/fs);
% s2_ori=cos(2*pi*(f0+fd)*t).*(t>=tao&t<=tao+T/fs);
s1_ori=1.*(t<=T/fs);
s2_ori=exp(j*2*pi*fd*t).*(t>=tao&t<=tao+T/fs);
% s1_ori=awgn(s1_ori,20);
% s2_ori=awgn(s2_ori,20);
NFFT=2^nextpow2(L);

ambiguity_mat=zeros(2*tao_max*fs+1,ceil(fd_max));
j=1;
for i=-tao_max*fs:tao_max*fs
%    s2=cos(2*pi*(f0+fd)*t).*(t>=(tao+i/fs)&t<=(tao+T/fs+i/fs));
   s2=exp(j*2*pi*fd*t).*(t>=(tao+i/fs)&t<=(tao+T/fs+i/fs));
   vec=ambiguity_vec(s1_ori,s2);
   ambiguity_mat(j,:)=vec(1:ceil(fd_max));
   j=j+1;
end

ambiguity_mat=ambiguity_mat';
[a,temp]=max(ambiguity_mat);
[b,column]=max(a);
row=temp(column);
tao_x=(column-1-tao_max*fs)/fs
fd_x=(row-1)*fs/NFFT
[tao_x_fit,fd_x_fit]=quadratic_surface_fitting(ambiguity_mat,row,column,fs,NFFT,tao_max)