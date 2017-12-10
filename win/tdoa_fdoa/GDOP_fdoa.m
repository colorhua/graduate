function gdop=GDOP_fdoa(S,X,V,f0,error_t,error_fd,error_s,error_v)
x=X(1);y=X(2);x0=S(1,1);y0=S(2,1);x1=S(1,2);y1=S(2,2);vx=V(1);vy=V(2);
c=3*10^8;error_r=c*error_t;error_vr=-c/f0*error_fd;
Rz=[error_vr^2 0;0 error_r^2];Rs=[error_s^2 0;0 error_s^2];Rv=[error_v^2 0;0 error_v^2];
r0=sqrt((x-x0)^2+(y-y0)^2);r1=sqrt((x-x1)^2+(y-y1)^2);
C=zeros(2);U=zeros(2);W=zeros(2);V=zeros(2);

% e1=(X(1)-S(1,2))/r1;e0=(X(1)-S(1,1))/r0;f1=(X(2)-S(2,2))/r1;f0=(X(2)-S(2,1))/r0;
% a1=(r1^2*V(1)-V(1)*(X(1)-S(1,2))^2-V(2)*(X(1)-S(1,2))*(X(2)-S(2,2)))/r1^3;
% a0=(r0^2*V(1)-V(1)*(X(1)-S(1,1))^2-V(2)*(X(1)-S(1,1))*(X(2)-S(2,1)))/r0^3;
% b1=(V(2)*r1^2-V(2)*(y-y1)^2-V(1)*(x-x1)*(y-y1))/r1^3;
% b0=(V(2)*r0^2-V(2)*(y-y0)^2-V(1)*(x-x0)*(y-y0))/r0^3;
% c1=(V(1)*(X(1)-S(1,2))^2+V(2)*(X(1)-S(1,2))*(X(2)-S(2,2))-r1^2*V(1))/r1^3;
% c0=(V(1)*(X(1)-S(1,1))^2+V(2)*(X(1)-S(1,1))*(X(2)-S(2,1))-r0^2*V(1))/r0^3;
% d1=(V(2)*(X(2)-S(2,2))^2+V(1)*(X(1)-S(1,2))*(X(2)-S(2,2))-r1^2*V(2))/r1^3;
% d0=(V(2)*(X(2)-S(2,1))^2+V(1)*(X(1)-S(1,1))*(X(2)-S(2,1))-r0^2*V(2))/r0^3;

a1=(vx*r1^2-(x-x1)^2*vx-(x-x1)*(y-y1)*vy)/r1^3;
b1=(vy*r1^2-(y-y1)^2*vy-(x-x1)*(y-y1)*vx)/r1^3;
b0=(vy*r0^2-(y-y0)^2*vy-(x-x0)*(y-y0)*vx)/r0^3;
c1=((x-x1)^2*vx+(x-x1)*(y-y1)*vy-vx*r1^2)/r1^3;
d1=((y-y1)^2*vy+(x-x1)*(y-y1)*vx-vy*r1^2)/r1^3;
a0=(vx*r0^2-(x-x0)^2*vx-(x-x0)*(y-y0)*vy)/r0^3;
c0=((x-x0)^2*vx+(x-x0)*(y-y0)*vy-vx*r0^2)/r0^3;
d0=((y-y0)^2*vy+(x-x0)*(y-y0)*vx-vy*r0^2)/r0^3;
e1=(x-x1)/r1;e0=(x-x0)/r0;f1=(y-y1)/r1;f0=(y-y0)/r0;

C=[a1-a0 b1-b0;e1-e0 f1-f0];U=[-c1 -d1;e1 f1];W=[c0 d0;-e0 -f0];V=[e1-e0 f1-f0;0 0];
Pdu=pinv(C)*(Rz+U*Rs*U'+W*Rs*W'+V*Rv*V')*pinv(C');
gdop=sqrt(Pdu(1,1)+Pdu(2,2));
end