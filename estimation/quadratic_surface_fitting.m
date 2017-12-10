function [correct_td,correct_fd] = quadratic_surface_fitting(choose_ambiguity_mat, delta_t, delta_f, td, fd)
A=reshape(choose_ambiguity_mat, 9, 1);
M=[1 -1 1 -1 1 1;
   0 0 1 0 1 1;
   1 1 1 1 1 1;
   1 0 0 -1 0 1;
   0 0 0 0 0 1;
   1 0 0 1 0 1;
   1 1 1 -1 -1 1;
   0 0 1 0 -1 1;
   1 -1 1 1 -1 1;];
C=pinv(M)*A;
temp=[delta_t^2;delta_t*delta_f;delta_f^2;delta_t;delta_f;1];
C=C./temp;
correct_td=td+(2*C(3)*C(4)-C(2)*C(5))/(C(2)^2-4*C(1)*C(3));
correct_fd=fd+(2*C(1)*C(5)-C(2)*C(4))/(C(2)^2-4*C(1)*C(3));
end