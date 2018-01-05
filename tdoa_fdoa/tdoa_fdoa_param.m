function [delta_t, delta_fd, angle0, angle1] = tdoa_fdoa_param(S0, S1, X, V, f0)
c = 3*10^8;
x = X(1); y = X(2);
x0 = S0(1); y0 = S0(2);
x1 = S1(1); y1 = S1(2);
vx = V(1); vy = V(2);
r0 = sqrt((x-x0)^2+(y-y0)^2);
r1 = sqrt((x-x1)^2+(y-y1)^2);
delta_t = (r1 - r0)/c;
delta_fd = -f0/c*(((x-x1)*vx+(y-y1)*vy)/r1-((x-x0)*vx+(y-y0)*vy)/r0);
angle0=atan((y-y0)/(x-x0));
angle1=atan((y-y1)/(x-x1));
end