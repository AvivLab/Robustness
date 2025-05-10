function [pops,rpops] = infallele2(N,mu,T,pop0)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pops=zeros(N,T);
rpops=zeros(N,T);
count=max(pop0);
pops(:,1)=pop0;
rpops(:,1)=pop0;

for i=2:T
    draw=unidrnd(N,[N,1]);
    bigcount=max(rpops(:,i-1));
    smallcount=0;
    indmp=zeros(1,bigcount);
    for j=1:N
       if rand()<mu
          count=count+1;
          bigcount=bigcount+1;
          cur=count;
          rcur=bigcount;
       else
           cur=pops(draw(j),i-1);
           rcur=rpops(draw(j),i-1);
           if indmp(rcur)==0
               smallcount=smallcount+1;
               indmp(rcur)=smallcount;
           end
           rcur=indmp(rcur);
       end
       pops(j,i)=cur;
       rpops(j,i)=rcur;
    end
end
end

