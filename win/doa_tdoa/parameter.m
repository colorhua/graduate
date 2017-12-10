function [delta_t,tan0,tan1]=parameter(S,X)
c=3*10^8;
delta_r=sqrt((X(1)-S(1,2))^2+(X(2)-S(2,2))^2)-sqrt((X(1)-S(1,1))^2+(X(2)-S(2,1))^2);
delta_t=delta_r/c;
tan0=(X(2)-S(2,1))/(X(1)-S(1,1));
tan1=(X(2)-S(2,2))/(X(1)-S(1,2));
end