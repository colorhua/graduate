close all; clear all; clc;
B=50*10^3;
Bn=200*10^3;
T=[10 20 50 100]*10^-3;
SNR=0;
gamma=10^(SNR/10);
sigma_tdoa=0.55./(B.*sqrt(Bn.*T.*gamma));
sigma_fdoa=0.55./(T.*sqrt(Bn.*T.*gamma));