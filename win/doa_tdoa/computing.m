function X=computing(delta_t,tan0,tan1,S)
X=[0 0]';r0=[0 0]';
c=3*10^8;
delta_r=delta_t*c;
k=0.5*(delta_r^2+(S(1,1)^2+S(2,1)^2)-(S(1,2)^2+S(2,2)^2));
A=[S(1,1)-S(1,2) S(2,1)-S(2,2);tan0 -1];
revA=pinv(A);
e=revA(1,1)*delta_r;f=revA(1,1)*k+revA(1,2)*(tan0*S(1,1)-S(2,1));
g=revA(2,1)*delta_r;h=revA(2,1)*k+revA(2,2)*(tan0*S(1,1)-S(2,1));
m=f-S(1,1);n=h-S(2,1);
j=e^2+g^2-1;p=2*(e*m+g*n);q=m^2+n^2;
r0(1)=(-p+sqrt(p^2-4*j*q))/(2*j);
r0(2)=(-p-sqrt(p^2-4*j*q))/(2*j);
if r0(1)>0&&r0(2)<=0
    X(1)=e*r0(1)+f;X(2)=g*r0(1)+h;
elseif r0(2)>0&&r0(1)<=0
    X(1)=e*r0(2)+f;X(2)=g*r0(2)+h;
else
    Y=[0 0;0 0];
    Y(1,1)=e*r0(1)+f;Y(2,1)=g*r0(1)+h;
    Y(1,2)=e*r0(2)+f;Y(2,2)=g*r0(2)+h;
    if abs((Y(2,1)-S(2,2))/(Y(1,1)-S(1,2))-tan1)<=abs((Y(2,2)-S(2,2))/(Y(1,2)-S(1,2))-tan1)
        X=Y(:,1);
    else
        X=Y(:,2);
    end
end
end