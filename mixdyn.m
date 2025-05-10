function [ps,robrs,robms] = mixdyn(n1,n2,indpairs,r,mu,ps0,T)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
l=length(indpairs);
R=mixedtensor(n1,n2,indpairs);
A=mixedAdj(n1,n2,indpairs)/(n1+n2);
ps=ps0;
robrs=zeros(1,T);
robms=zeros(1,T);
weights=zeros(1,l);
for i=1:l
    weights(i)=nchoosek(n1,indpairs(i,1)-1);
end
weightsum=weights*ps;
ps=ps/weightsum;
for t=1:T
   newps=A*ps;
   weightsum=weights*newps;
   robms(t)=weightsum;
   ps=(1-mu)*ps+mu*newps;
   ps=ps/((1-mu)+mu*weightsum);
   for k=1:l
       newps(k)=ps'*R(:,:,k)*ps;
   end
   weightsum=weights*newps;
   robrs(t)=weightsum;
   ps=(1-r)*ps+r*newps;
   ps=ps/((1-r)+r*weightsum);
end

end