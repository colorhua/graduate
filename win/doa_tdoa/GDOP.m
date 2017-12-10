function gdop=GDOP(S,X,error_0,error_s,error_t)
% C=[0 0;0 0];B=[0 0;0 0];c=3*10^8;
% error_r=error_t*c;
% r1=sqrt((X(1)-S(1,2))^2+(X(2)-S(2,2))^2);
% r0=sqrt((X(1)-S(1,1))^2+(X(2)-S(2,1))^2);
% sin0=(X(2)-S(2,1))/r0;
% cos0=(X(1)-S(1,1))/r0;
% C(1,1)=-sin0^2/(X(2)-S(2,1));
% C(1,2)=cos0^2/(X(1)-S(1,1));
% C(2,1)=(X(1)-S(1,2))/r1-(X(1)-S(1,1))/r0;
% C(2,2)=(X(2)-S(2,2))/r1-(X(2)-S(2,1))/r0;
% B(1,1)=error_0^2+error_s^2/r0^2;
% B(2,2)=error_r^2+2*error_s^2;
% Pdx=pinv(C)*B*pinv(C');
% gdop=sqrt(Pdx(1,1)+Pdx(2,2));

c=3*10^8;C=zeros(2);U=zeros(2);W=zeros(2);
error_r=c*error_t;
x=X(1);y=X(2);x0=S(1,1);y0=S(2,1);x1=S(1,2);y1=S(2,2);
r1=sqrt((x-x1)^2+(y-y1)^2);r0=sqrt((x-x0)^2+(y-y0)^2);
sin0=(y-y0)/r0;cos0=(x-x0)/r0;
C=[-sin0^2/(y-y0) cos0^2/(x-x0); (x-x1)/r1-(x-x0)/r0 (y-y1)/r1-(y-y0)/r0];
U=[sin0^2/(y-y0) -cos0^2/(x-x0); (x-x0)/r0 (y-y0)/r0];
W=[0 0; (x-x1)/r1 (y-y1)/r1];
Rv=[error_0^2 0; 0 error_r^2];Rs=[error_s^2 0; 0 error_s^2];
Pdx=pinv(C)*(Rv+U*Rs*U'+W*Rs*W')*pinv(C)';
gdop=sqrt(Pdx(1,1)+Pdx(2,2));
end