function s_td_fd = recreation(s, td, fd, fs)
L=length(s);
t=0:1/fs:(L-1)/fs;
td_N=int32(td*fs);
if td_N>0
   s=[zeros(1,td_N) s(1:L-td_N)];
else
   td_N=-td_N; 
   s=[s(td_N+1:end) zeros(1,td_N)]; 
end
s_td_fd=s.*exp(1j*2*pi*fd*t);
end