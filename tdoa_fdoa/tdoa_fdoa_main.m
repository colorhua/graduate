close all; clear all; clc;
f0 = 10*10^9;V=[300, 0];
S0 = [-5,0]*10^3; S1 = [5,0]*10^3; X = [0,10000];
[delta_t, delta_fd] = tdoa_fdoa_param(S0, S1, X, V, f0);
sigma_t = 1*10^-6;
sigma_fd = 5;
sigma_s = 5;
sigma_v = 5;
gdop=tdoa_fdoa_gdop(S0,S1,X,V,f0,sigma_t,sigma_fd,sigma_s,sigma_v)/1000


N = 100; M = 60000;
x = linspace(-M, M, N); y = linspace(-M, M, N);
gdop = zeros(N);

for i = 1:N
    for j = 1:N
        X(1) = x(i); X(2) = y(j);
        gdop(j,i) = tdoa_fdoa_gdop(S0, S1, X, V, f0, sigma_t, sigma_fd, sigma_s, sigma_v);
    end
end

[c,h] = contour(x/1000, y/1000, gdop/1000);
set(h,'ShowText','on','LevelList',[0:0.5:10]);
xlabel('x/km'); ylabel('y/km');
title('sigma_t=20ns,sigma_fd=2Hz,sigma_s=5m,sigma_v=5m/s,value of GDOP/km');

% f0 = 2*10^9;V=[0, 150];
% S0 = [-5,0]*10^3; S1 = [5,0]*10^3; X = [0,10000];
% % [delta_t, delta_fd] = tdoa_fdoa_param(S0, S1, X, V, f0);
% sigma_t = 20*10^-9;
% sigma_fd = 5;
% sigma_s = 5;
% sigma_v = 5;
% gdop=tdoa_fdoa_gdop(S0,S1,X,V,f0,sigma_t,sigma_fd,sigma_s,sigma_v)/1000
% 
% 
% N = 100; M = 60000;
% x = linspace(-M, M, N); y = linspace(-M, M, N);
% gdop = zeros(N);
% 
% for i = 1:N
%     for j = 1:N
%         X(1) = x(i); X(2) = y(j);
%         gdop(j,i) = tdoa_fdoa_gdop(S0, S1, X, V, f0, sigma_t, sigma_fd, sigma_s, sigma_v);
%     end
% end
% 
% figure(1)
% subplot(1,2,1)
% [c,h] = contour(x/1000, y/1000, gdop/1000);
% set(h,'ShowText','on','LevelList',[0:0.5:10]);
% 
% f0 = 1*10^9;V=[150, 150];
% S0 = [-5,0]*10^3; S1 = [5,0]*10^3; X = [0,10000];
% [delta_t, delta_fd] = tdoa_fdoa_param(S0, S1, X, V, f0);
% sigma_t = 20*10^-9;
% sigma_fd = 5;
% sigma_s = 5;
% sigma_v = 5;
% % gdop=tdoa_fdoa_gdop(S0,S1,X,V,f0,sigma_t,sigma_fd,sigma_s,sigma_v)/1000
% 
% 
% N = 100; M = 60000;
% x = linspace(-M, M, N); y = linspace(-M, M, N);
% gdop = zeros(N);
% 
% for i = 1:N
%     for j = 1:N
%         X(1) = x(i); X(2) = y(j);
%         gdop(j,i) = tdoa_fdoa_gdop(S0, S1, X, V, f0, sigma_t, sigma_fd, sigma_s, sigma_v);
%     end
% end
% 
% figure(1)
% subplot(1,2,2)
% [c,h] = contour(x/1000, y/1000, gdop/1000);
% set(h,'ShowText','on','LevelList',[0:0.5:10]);
% xlabel('x/km'); ylabel('y/km');
