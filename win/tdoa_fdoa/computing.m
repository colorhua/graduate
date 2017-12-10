function comX=computing(delta_t,delta_fd,S,X,f0,V);
c=3*10^8;
comX=[0 0]';r0=[0 0]';
delta_r=delta_t*c;
k1=(delta_r^2+(S(1,1)^2+S(2,1)^2)-(S(1,2)^2+S(2,2)^2))/2;
k2=c*delta_fd/(f0*delta_r);
k3=((S(1,1)-S(1,2))*V(1)+(S(2,1)-S(2,2))*V(2))/delta_r+c*delta_fd/f0;
k4=S(1,1)*V(1)+S(2,1)*V(2);
q=V(1)/(S(1,1)-S(1,2));
r0(1)=(-(k3-q*delta_r)-sqrt((k3-q*delta_r)^2-4*k2*(k4-q*k1)))/(2*k2);
r0(2)=(-(k3-q*delta_r)+sqrt((k3-q*delta_r)^2-4*k2*(k4-q*k1)))/(2*k2);
x12=(k1+delta_r*r0(1))/(S(1,1)-S(1,2));
x34=(k1+delta_r*r0(2))/(S(1,1)-S(1,2));
y1=S(2,1)-sqrt(r0(1)^2-(x12-S(1,1))^2);
y2=S(2,1)+sqrt(r0(1)^2-(x12-S(1,1))^2);
y3=S(2,1)-sqrt(r0(2)^2-(x34-S(1,1))^2);
y4=S(2,1)+sqrt(r0(2)^2-(x34-S(1,1))^2);
X_mul=[x12 x12 x34 x34;y1 y2 y3 y4];
e=X_mul-[X X X X];
e=e.*e;
e=e(1,:)+e(2,:);
e=abs(e);
[small,index]=min(e);
comX=[X_mul(1,index) X_mul(2,index)]';
end