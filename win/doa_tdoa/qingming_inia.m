clc;clear all;
N=500;
input=zeros(N,3);output=zeros(N,2);
X0=[-500 0]';X1=[500 0]';
S = [X0, X1];
for k=1:N
%     X0=(2*rand-1)*60000*[1 0]'+(2*rand-1)*60000*[0 1]';
%     X1=(2*rand-1)*60000*[1 0]'+(2*rand-1)*60000*[0 1]';
    S=[X0,X1];
    X=(2*rand-1)*60000*[1 0]'+(2*rand-1)*60000*[0 1]';
    output(k,:)=X;
    [delta_t,tan0,tan1]=parameter(S,X);
%     input(:,k)=[delta_t;tan0;tan1;delta_t^2;tan0^2;tan1^2;delta_t*tan0;delta_t*tan1;tan0*tan1];
    input(k,:)=[delta_t;tan0;tan1];
end
% for k = 1:N
%     x = -20000 + k*400;
%     y = 2*x + 500;
%     X = [x y]';
%     output(k,:)=X;
%     [delta_t,tan0,tan1]=parameter(S,X);
%     input(k,:)=[delta_t;tan0;tan1];
% end
data = zeros(N, 5);
data = [input,output];
csvwrite('data.csv',data);