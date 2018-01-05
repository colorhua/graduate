close all; clear all; clc;
f0 = 1*10^9;
V=[150, 0];
S0 = [-5,0]*10^3; S1 = [5,0]*10^3;
sigma_t = 10*10^-9;
sigma_fd = 1;
sigma_angle=3*10^-3;
M=10000;
data=zeros(M,6);
for i=1:M
    X=[unifrnd(-60*10^3,60*10^3) unifrnd(-60*10^3,60*10^3)];
    [delta_t, delta_fd, angle0, angle1] = tdoa_fdoa_param(S0, S1, X, V, f0);
    delta_t=delta_t+normrnd(0,sigma_t);
    delta_fd=delta_fd+normrnd(0,sigma_fd);
    angle0=angle0+normrnd(0,sigma_angle);
    angle1=angle1+normrnd(0,sigma_angle);
    data(i,:)=[delta_t delta_fd angle0 angle1 X];
end
scatter(data(:,5),data(:,6));
csvwrite('data.csv',data);
