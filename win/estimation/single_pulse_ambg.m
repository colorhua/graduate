function x=single_pulse_ambg(taup)
% colormap(gray(1))
eps=0.000001;
i=0;
del=2*taup/150;
for tau=-taup:del:taup
   i=i+1;
   j=0;
   fd=linspace(-5/taup,5/taup,151);
   val1=1.-abs(tau)/taup;
   val2=pi*taup.*(1.0-abs(tau)/taup).*fd;
   x(:,i)=abs(val1*sin(val2+eps)./(val2+eps));
end
end