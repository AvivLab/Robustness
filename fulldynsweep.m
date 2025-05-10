function psss = fulldynsweep(n,indss,r,mus,mode)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    N=length(indss);
    psss=cell(1,N);
    eps=10^(-6);
    for i=1:N
        i
       inds=indss{i};
       l=length(inds);
       %m1=length(rs);
       m2=length(mus);
       pss=zeros(l,m2);
       %for j=1:m1
           for k=1:m2
               k
               %r=rs(j);
               mu=mus(k);
               pss(:,k)=fulldyn(n,inds,r,mu,ones(l,1)/l,0,mode,eps,false);            
           end
       %end
       psss{i}=pss;
    end
end

