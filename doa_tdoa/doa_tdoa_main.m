clc;
close all;
clear all;
S0 = [-5, 0]*10^3;
S1 = [5, 0]*10^3;
sigma_angle = 3*10^-3; 
sigma_S = 5; 
sigma_t = 20*10^-9;
%X = [1000, 5000];
%doa_tdoa_gdop(S0, S1, X, sigma_angle, sigma_S, sigma_t)
N = 100; M = 60*10^3;
x = linspace(-M, M, N); y = linspace(-M, M, N);
gdop = zeros(N);
for i = 1:N
    for j = 1:N
        X(1) = x(i); X(2) = y(j);
        gdop(j,i) = doa_tdoa_gdop(S0, S1, X, sigma_angle, sigma_S, sigma_t)/1000;
    end
end

figure(1)
subplot(1,2,1)
[c, h] = contour(x/1000, y/1000, gdop);
set(h,'ShowText','on','LevelList',[0:0.5:10]);
xlabel('x/km');
ylabel('y/km');
hold on;
% title('sigma_a=3mrad,sigma_S=5m,sigma_t=20ns,value of GDOP/k');

S0 = [-0.5, 0]*10^3;
S1 = [0.5, 0]*10^3;
sigma_angle = 3*10^-3; 
sigma_S = 5; 
sigma_t = 20*10^-9;
%X = [1000, 5000];
%doa_tdoa_gdop(S0, S1, X, sigma_angle, sigma_S, sigma_t)
N = 100; M = 60*10^3;
x = linspace(-M, M, N); y = linspace(-M, M, N);
gdop = zeros(N);
for i = 1:N
    for j = 1:N
        X(1) = x(i); X(2) = y(j);
        gdop(j,i) = doa_tdoa_gdop(S0, S1, X, sigma_angle, sigma_S, sigma_t)/1000;
    end
end

figure(1)
subplot(1,2,2)
[c, h] = contour(x/1000, y/1000, gdop);
set(h,'ShowText','on','LevelList',[0:10:100]);
xlabel('x/km');
ylabel('y/km');