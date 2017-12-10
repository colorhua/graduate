function vec = ambiguity_vec(s1, s2)
L=length(s1);
NFFT=2^nextpow2(L);
pro=s1.*s2;
PRO=fft(pro,NFFT)/NFFT;
vec=abs(PRO);
end