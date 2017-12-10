function [tao,fd]=quadratic_surface_fitting(ambiguity_mat,row,column,fs,NFFT,tao_max)
delta_tao=1/fs;
delta_fd=fs/NFFT;
A=reshape(ambiguity_mat(row-1:row+1,column-1:column+1)',9,1);
M=[1 -1 1 -1 1 1;0 0 1 0 1 1;1 1 1 1 1 1;1 0 0 -1 0 1;0 0 0 0 0 1;1 0 0 1 0 1;1 1 1 -1 -1 1;0 0 1 0 -1 1;1 -1 1 1 -1 1];
C=pinv(M)*A;
temp=[delta_tao^2;delta_tao*delta_fd;delta_fd^2;delta_tao;delta_fd;1];
C=C./temp;
tao=(column-1-tao_max*fs)/fs+(2*C(3)*C(4)-C(2)*C(5))/(C(2)^2-4*C(1)*C(3));
fd=(row-1)*fs/NFFT+(2*C(1)*C(5)-C(2)*C(4))/(C(2)^2-4*C(1)*C(3));
end