function snr=SNR_singlech(I,In)
% 计算信噪比函数
% I :original signal
% In:noisy signal(ie. original signal + noise signal)
snr=0;
Ps=sum(abs(I).^2)/length(I);
Pn=sum(abs(In-I).^2)/length(I);
% Ps=sum(sum((I-mean(mean(I))).^2));%signal power
% Pn=sum(sum((I-In).^2));           %noise power
snr=10*log10(Ps/Pn);
% 其中I是纯信号，In是带噪信号，snr是信噪比
end