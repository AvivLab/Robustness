function [ps,rob] = mixdyn(R,r,mu,ps0,T)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N=length(R);
ps=ps0;
rob=[];
for t=1:T
   newps=mutate(d,ps,mu);
   newps=zeros(N,1);
   for k=1:N
       newps(k)=ps'*R(:,:,k)*ps;
   end
   ps=(1-r)*ps+r*newps;
   
   rob=[rob,sum(ps)];
   ps=ps/sum(ps);
end
plot(rob);


end