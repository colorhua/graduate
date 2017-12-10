function [delta_t,delta_fd]=parameter(S,X,V,f0)
c=3*10^8;
r1=sqrt((X-S(:,2))'*(X-S(:,2)));
r0=sqrt((X-S(:,1))'*(X-S(:,1)));
delta_t=(r1-r0)/c;
delta_fd=-f0/c*((X-S(:,2))'*V/r1-(X-S(:,1))'*V/r0);
end