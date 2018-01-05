clc;clear all;close all;
data=csvread('data.csv');
f0 = 1*10^9;V=[150, 0];
S0 = [-5,0]*10^3; S1 = [5,0]*10^3;
mse=0;
comX_mat=zeros(9000,2);
for i=1:9000
    delta_t=data(i,1);
    delta_fd=data(i,2);
    angle0=data(i,3);
    angle1=data(i,4);
    comX=computing(delta_t, delta_fd, angle0, angle1, S0, S1, f0, V);
    comX_mat(i,:)=comX;
    mse=mse+(comX(1)-data(i,5))^2+(comX(2)-data(i,6))^2;
end
mse=mse/9000;
rmse=sqrt(mse);
error=abs(comX_mat-data(1:9000,5:6));