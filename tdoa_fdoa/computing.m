function comX=computing(delta_t, delta_fd, angle0, angle1, S0, S1, f0, V)

% f0 = 1*10^9;V=[150, 0];
% S0 = [-5,0]*10^3; S1 = [5,0]*10^3;
% X=[-40, 10]*10^3;
% [delta_t, delta_fd, angle0, angle1] = tdoa_fdoa_param(S0, S1, X, V, f0);

c=3*10^8;
comX=[0 0];
delta_r=c*delta_t;
x0=S0(1); y0=S0(2); x1=S1(1); y1=S1(2);
vx=V(1); vy=V(2);
k1=(delta_r^2+(x0^2+y0^2)-(x1^2+y1^2))/2;
k2=c*delta_fd/(f0*delta_r);
k3=((x0-x1)*vx+(y0-y1)*vy)/delta_r+c*delta_fd/f0;
k4=x0*vx+y0*vy;
q=vx/(x0-x1);
if (-(k3-q*delta_r)+sqrt((k3-q*delta_r)^2-4*k2*(k4-q*k1)))/(2*k2)>0
    r0=(-(k3-q*delta_r)+sqrt((k3-q*delta_r)^2-4*k2*(k4-q*k1)))/(2*k2);
elseif (-(k3-q*delta_r)-sqrt((k3-q*delta_r)^2-4*k2*(k4-q*k1)))/(2*k2)>0
    r0=(-(k3-q*delta_r)-sqrt((k3-q*delta_r)^2-4*k2*(k4-q*k1)))/(2*k2);
else
    X=doa_tdoa_computing(delta_t,angle0,angle1,S0,S1);
    comX=X';
    return
end
comx=(k1+delta_r*r0)/(x0-x1);
if r0^2-(comx-x0)^2>0
    comy1=y0+sqrt(r0^2-(comx-x0)^2);
    comy2=y0-sqrt(r0^2-(comx-x0)^2);
else
    X=doa_tdoa_computing(delta_t,angle0,angle1,S0,S1);
    comX=X';
    return
end
Q1=[x0 y0];
Q2=[0 y0-tan(angle0)*x0];
P1=[comx comy1];
P2=[comx comy2];
d1 = abs(det([Q2-Q1;P1-Q1]))/norm(Q2-Q1);
d2 = abs(det([Q2-Q1;P2-Q1]))/norm(Q2-Q1);
if d1<d2
    comX=P1;
else
    comX=P2;
end
end