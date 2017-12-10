close all;clear all;clc;
f0=1*10^9;V=[150 0]';
X0=[-500 0]';X1=[500 0]';S=[X0 X1];X=[0 10000]';
error_t=20*10^-9;error_fd=2;error_s=0.5;error_v=1;

% error_t=0;error_fd=0;error_s=0;error_v=0;
% [delta_t,delta_fd]=parameter(S,X,V,f0);
% delta_t=delta_t+normrnd(0,error_t);
% delta_fd=delta_fd+normrnd(0,error_t);
% S=S+[normrnd(0,error_s) normrnd(0,error_s);normrnd(0,error_s) normrnd(0,error_s)];
% V=V+normrnd(0,error_v);
% sum=0;
% for i=1:100000
%     comX=computing(delta_t,delta_fd,S,X,f0,V);
%     e=sqrt((comX-X)'*(comX-X));
%     sum=sum+e;
% end
% sum/100000
% 
gdop=GDOP_fdoa(S,X,V,f0,error_t,error_fd,error_s,error_v)

N=100;M=40000;
x=linspace(-M,M,N);y=linspace(-M,M,N);
gdop_com=zeros(N);gdop=zeros(N);

% comX=[0 0]';
% for j=1:N
%     for i=1:N
%         X(1)=x(i);X(2)=y(j);
%         sum=0;
%         for k=1:100
%             [delta_t,delta_fd]=parameter(S,X,V,f0);
%             delta_t=delta_t+normrnd(0,error_t);
%             delta_fd=delta_fd+normrnd(0,error_fd);
%             S=S+[normrnd(0,error_s) normrnd(0,error_s);normrnd(0,error_s) normrnd(0,error_s)];
%             V=V+normrnd(0,error_v);
%             comX=computing(delta_t,delta_fd,S,X,f0,V);
%             sum=sum+sqrt((comX-X)'*(comX-X));
%             gdop_com(i,j)=sum/100;
%         end
%     end
% end
% 
for j=1:N
    for i=1:N
        X(1)=x(i);X(2)=y(j);
        gdop(i,j)=GDOP_fdoa(S,X,V,f0,error_t,error_fd,error_s,error_v);
    end
end

% the_com_error=abs(gdop_com-gdop);
% the_com_error_re=reshape(gdop/1000,1,[]);
% hist(the_com_error_re,min(the_com_error_re):0.0005:max(the_com_error_re));
% xlabel('x/km');ylabel('value');title('histogram');

[c,h]=contour(x/1000,y/1000,gdop');
% a=reshape(gdop/1000,1,[]);sort_a=sort(a);
set(h,'ShowText','on','LevelList',[0:1000:50000]);
xlabel('x/km');ylabel('y/km');title('error_t=20ns,error_fd=2Hz,error_s=0.5m,error_v=1m/s,value of GDOP');