clear all;clc;
X0=[-500 0]';X1=[500 0]';S=[X0 X1];X=[3500 5000]';
% error_0=0;error_s=0;error_t=0;
error_0=3*10^-3;error_s=0.5;error_t=20*10^-9;
% [delta_t,tan0,tan1]=parameter(S,X);
% comX=computing(delta_t,tan0,tan1,S);
GDOP(S,X,error_0,error_s,error_t)
N=100;M=40000;
x=linspace(-M,M,N);y=linspace(-M,M,N);
gdop=zeros(N);

for j=1:N
    for i=1:N;
        X(1)=x(i);X(2)=x(j);
        gdop(i,j)=GDOP(S,X,error_0,error_s,error_t);
    end
end

% comX=[0 0]';
% for j=1:N
%     for i=1:N
%         X(1)=x(i);X(2)=y(j);
%         sum=0;
%         for k=1:100
%             [delta_t,tan0,tan1]=parameter(S,X);
%             delta_t=delta_t+normrnd(0,error_t);
%             tan0=tan0+normrnd(0,error_0);
%             S=S+[normrnd(0,error_s) normrnd(0,error_s);normrnd(0,error_s) normrnd(0,error_s)];
%             tan1=tan1+normrnd(0,error_0);
%             comX=computing(delta_t,tan0,tan1,S);
%             sum=sum+sqrt((comX-X)'*(comX-X));
%             gdop(i,j)=sum/100;
%         end
%     end
% end

[c,h]=contour(x/1000,y/1000,gdop');
% a=reshape(gdop,1,[]);sort_a=sort(a);
set(h,'ShowText','on','LevelList',[0:3000:100000]);
xlabel('x/km');ylabel('y/km');title('error_a=3mrad,error_s=0.5m,error_t=20ns,value of GDOP');