function [ps,prs] = fullmoddyn(n,inds,rs,mu,ps0,T,mode)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
indsplus=[inds;inds+2^n];
l=length(inds);
R=modtensor(n,rs,inds,mode);
A=getFullAdj(2*ones(n+1,1),0);
A=A(indsplus,indsplus);
ps=ps0;
robrs=zeros(1,T);
robms=zeros(1,T);
ps=ps/sum(ps);
prs=zeros(1,T);
for t=1:T  
   newps=A*ps;
   mysum=sum(newps);
   robms(t)=mysum;
   ps=(1-mu)*ps+mu*newps;
   ps=ps/((1-mu)+mu*mysum);
   for k=1:(2*l)
       newps(k)=ps'*R(:,:,k)*ps;
   end
   mysum=sum(newps);
   robrs(t)=mysum;
   ps=newps/mysum;
   prs(t)=sum(ps(1:l));
end

end