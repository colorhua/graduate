close all; clear all; clc;
f0 = 1*10^9;V=[300, 0];
S0 = [-5,0]*10^3; S1 = [5,0]*10^3; X = [-40,40]*10^3;
[delta_t, delta_fd]=tdoa_fdoa_param(S0, S1, X, V, f0);
N = 5000; M = 100000;
x = linspace(-M, M, N); y = linspace(-M, M, N);
delta_t_mat=zeros(N);
delta_fd_mat=zeros(N);
f1_mat=zeros(N);
f0_mat=zeros(N);

for i = 1:N
    for j = 1:N
        X(1) = x(i); X(2) = y(j);
        [delta_t, delta_fd, angle0, angle1, f1, f0] = tdoa_fdoa_param(S0, S1, X, V, f0);
        delta_t_mat(j,i)=delta_t;
        delta_fd_mat(j,i)=delta_fd;
        f1_mat(j,i)=f1;
        f0_mat(j,i)=f0;
    end
end

delta_t_max=max(max(delta_t_mat));
delta_t_min=min(min(delta_t_mat));
delta_fd_max=max(max(delta_fd_mat));
delta_fd_min=min(min(delta_fd_mat));
f1_max=max(max(f1_mat));
f1_min=min(min(f1_mat));
f0_max=max(max(f0_mat));
f0_min=min(min(f0_mat));