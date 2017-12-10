function gdop = tdoa_fdoa_gdop(S0, S1, X, V, f0, sigma_t, sigma_fd, sigma_s, sigma_v)
x = X(1); y = X(2); x0 = S0(1); y0 = S0(2);
x1 = S1(1); y1 = S1(2); vx = V(1); vy = V(2);
c = 3*10^8; sigma_r = c*sigma_t; sigma_vr = -c/f0*sigma_fd;
Rz = [sigma_vr^2, 0; 0, sigma_r^2];
Rs = [sigma_s^2, 0; 0, sigma_s^2];
Rv = [sigma_v^2, 0; 0, sigma_v^2];
r0 = sqrt((x - x0)^2 + (y - y0)^2);
r1 = sqrt((x - x1)^2 + (y - y1)^2);
C = zeros(2); U = zeros(2); W = zeros(2); V = zeros(2);
a1 = (vx*r1^2-(x-x1)^2*vx-(x-x1)*(y-y1)*vy)/r1^3;
b1 = (vy*r1^2-(y-y1)^2*vy-(x-x1)*(y-y1)*vx)/r1^3;
b0 = (vy*r0^2-(y-y0)^2*vy-(x-x0)*(y-y0)*vx)/r0^3;
c1 = ((x-x1)^2*vx+(x-x1)*(y-y1)*vy-vx*r1^2)/r1^3;
d1 = ((y-y1)^2*vy+(x-x1)*(y-y1)*vx-vy*r1^2)/r1^3;
a0 = (vx*r0^2-(x-x0)^2*vx-(x-x0)*(y-y0)*vy)/r0^3;
c0 = ((x-x0)^2*vx+(x-x0)*(y-y0)*vy-vx*r0^2)/r0^3;
d0 = ((y-y0)^2*vy+(x-x0)*(y-y0)*vx-vy*r0^2)/r0^3;
e1 = (x-x1)/r1;
e0 = (x-x0)/r0;
f1 = (y-y1)/r1;
f0 = (y-y0)/r0;
C = [a1 - a0, b1 - b0; e1 - e0, f1 - f0];
U = [-c1, -d1; e1, f1];
W = [c0, d0; -e0, -f0];
V = [e1 - e0, f1 - f0; 0, 0];
Pdu = pinv(C)*(Rz+U*Rs*U'+W*Rs*W'+V*Rv*V')*pinv(C)';
gdop = sqrt(Pdu(1,1)+Pdu(2,2));
end