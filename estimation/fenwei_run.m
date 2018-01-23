clc;clear all;close all;
%% 生成原始信号
fs_a=1*10^9;
fs_d=200*10^3;
td_ini=19.87*10^-6;
fd_ini=14.08;
T=0.1;
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
%% 信号采样
y_d1=downsample(y_a1,fs_a/fs_d);
y_d2=downsample(y_a2,fs_a/fs_d);
%% 构造噪声低通滤波器
Bn=50*10^3;
fn_h=Bn;
Wn=fn_h/(fs_d/2);
[b,a]=butter(8,Wn,'low');
%% 循环
%% 循环
sum_tdoa=0;
sum_fdoa=0;
SNR_mat=[-10 -5 0 5 10 15];
tdoa=zeros(1,100);
fdoa=zeros(1,100);
%% 用wgn加噪声
y_d1_power=sum(abs(y_d1).^2)/length(y_d1);
y_d2_power=sum(abs(y_d2).^2)/length(y_d2);
for m=1:6
    NOISE1_power=y_d1_power / ( 10^(SNR/10) );
    NOISE2_power=y_d2_power / ( 10^(SNR/10) );
    for i=1:100
        NOISE1=wgn(1,length(y_d1),10*log10(NOISE1_power),'complex');
        NOISE2=wgn(1,length(y_d2),10*log10(NOISE2_power),'complex');
        %% 构造带限噪声
        NOISE_band1=filter(b,a,NOISE1);
        NOISE_band2=filter(b,a,NOISE2);
        NOISE_band1=NOISE_band1*sqrt(NOISE1_power/(std(NOISE_band1)^2));
        NOISE_band2=NOISE_band2*sqrt(NOISE2_power/(std(NOISE_band2)^2));
        y_dn1=y_d1+NOISE_band1;
        y_dn2=y_d2+NOISE_band2;
        L=length(y_dn1);
        Nf=2^nextpow2(2*L-1);
        Y_dn1=fft(y_dn1,Nf);
        Y_dn2=fft(y_dn2,Nf);
        %% 每一路信号的功率谱
        R1=conj(Y_dn1).*Y_dn1;
        R2=conj(Y_dn2).*Y_dn2;
        %% 每一路信号的自相关函数
        r1=ifft(R1,Nf);
        r2=ifft(R2,Nf);
        r1=ifftshift(r1);
        r2=ifftshift(r2);
        r1_jiequ=r1(Nf/2+1-(L-1):Nf/2+1+(L-1));
        r2_jiequ=r2(Nf/2+1-(L-1):Nf/2+1+(L-1));
        %% 对自相关函数进行M倍抽取
        fs_pie=100;
        M=fs_d/fs_pie;
        r1_pie=downsample(r1_jiequ,M);
        r2_pie=downsample(r2_jiequ,M);
        %% 计算自相关函数之比
        kesi=r2_pie./r1_pie;
        fd_max=40;
        Wn_fd=fd_max/fs_pie;
        b_fd=fir1(96,Wn_fd,'low');
        kesi_f=filter(b_fd,1,kesi);
        kesi_L=length(kesi);
        %% 加窗函数
        win = hamming(kesi_L);
        kesi_w = kesi_f.*win';
        %% 自相关函数之比补零
        delta_f=0.01;
        N_pie=2^nextpow2(fs_pie/delta_f);
        kesi_pie=[kesi_w zeros(1,N_pie-kesi_L)];
        %% 计算自相关函数之比的频谱
        Fai=fft(kesi_pie,N_pie)/N_pie;
        %% 搜索频谱，得到峰值
        [Fai_max,k_max]=max(abs(Fai(1:fix(fd_max/(fs_pie/N_pie)))));
        fd=(k_max-1)*fs_pie/N_pie;
        %% 计算时差
        %% 信号频差补偿
        y2_xz=y_dn2.*exp(-1j*2*pi*fd_ini*t_d);
        Y2_xz=fft(y2_xz,Nf);
        %% 频域截取？
        R12=conj(Y_dn1).*Y2_xz;
        delta_t=0.01*10^-6;
        %% 张文
        fs_pie_t=1/delta_t;
        T_pie=200*10^-6;
        M_t=int32(Nf/(T_pie*fs_d));
        R12_M=downsample(R12,M_t);
        R12_M_L=length(R12_M);
        if rem(R12_M_L,2)==1
            R12_M=[R12_M(1:(R12_M_L-1)/2) R12_M((R12_M_L-1)/2+2:R12_M_L)];
        end
        R12_M_L=length(R12_M);
        Nf_pie_t=2^nextpow2(fs_pie_t*T_pie);
        R12_w=R12_M;
        R12_pie=[R12_w(1:R12_M_L/2) zeros(1,Nf_pie_t-R12_M_L) R12_w(R12_M_L/2+1:R12_M_L)];
        r12_pie=ifft(R12_pie,Nf_pie_t);
        r12_pie=ifftshift(r12_pie);
        [r_max,n_max]=max(abs(r12_pie));
        td=(n_max-Nf_pie_t/2)*(T_pie/(Nf_pie_t-1));
        %% 累计
        fdoa(i)=fd;
        tdoa(i)=td;
    end
    mean_fdoa=mean(fdoa);
    mean_tdoa=mean(tdoa);
    sum_fdoa=sum((fdoa-mean_fdoa).^2);
    sum_tdoa=sum((tdoa-mean_tdoa).^2);
    disp(SNR);
    sigma_tdoa=sqrt(sum_tdoa/99)
    sigma_fdoa=sqrt(sum_fdoa/99)
end