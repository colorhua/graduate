close all;clear all;clc;
% %%
% %single_pulse_ambg
eps=0.000001;
taup=3;
x=single_pulse_ambg(taup);
taux=linspace(-taup,taup,size(x,1));
fdy=linspace(-5/taup+eps,5/taup-eps,size(x,1));
% figure(1)
subplot(2,2,1)
mesh(taux,fdy,x);
xlabel('Delay-seconds');ylabel('Doppler-Hz');zlabel('Ambiguity funcion');
title('single-pulse-ambg');
% figure(2)
% contour(taux,fdy,x);grid on;
% xlabel('Delay-seconds');ylabel('Doppler-Hz');
% title('single-pulse-ambg');
%%
%lfm_ambg
eps=0.0001;taup=1;b=10;up_down=1;
x=lfm_ambg(taup,b,up_down);
taux=-1.1*taup:0.05:1.1*taup;
fdy=-b:0.05:b;
% figure(1)
subplot(2,2,2)
mesh(taux,fdy,x);
xlabel('Delay-seconds');ylabel('Doppler-Hz');zlabel('Ambiguity funcion');
title('lfm-ambg');
% figure(2)
% contour(taux,fdy,x);grid on;
% xlabel('Delay-seconds');ylabel('Doppler-Hz');
% title('lfm-ambg');
%%
%train_ambg
taup=0.2;
pri=1;
n=5;
x=train_ambg(taup,n,pri);
taux=linspace(-taup,taup,size(x,2));
fdy=linspace(-5/taup+eps,5/taup-eps,size(x,1));
% figure(1)
subplot(2,2,3)
mesh(taux,fdy,x);
xlabel('Delay-seconds');ylabel('Doppler-Hz');zlabel('Ambiguity funcion');
title('train-ambg');
% figure(2)
% contour(taux,fdy,x);grid on;
% xlabel('Delay-seconds');ylabel('Doppler-Hz');
% title('train-ambg');
%%
%train_ambg_lfm
% clear all; close all;
taup = 0.4;
pri = 1;
n = 3;
bw = 10;
x = train_ambg_lfm(taup, n, pri, bw);
% figure(1)
subplot(2,2,4);
time = linspace(-(n-1)*pri-taup, n*pri-taup, size(x,2));
doppler = linspace(-bw,bw, size(x,1));
mesh(time, doppler, x);
grid on;
xlabel('Delay-seconds');
ylabel('Doppler-Hz');
zlabel('Ambiguity function');
title('train-lfm-ambg');
% figure(2)
% contour(time, doppler, (x));grid on;
% xlabel('Delay-seconds');
% ylabel('Doppler-Hz');
% title('train-lfm-ambg');