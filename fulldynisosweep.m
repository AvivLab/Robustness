function psss = fulldynisosweep(n,indss,r,mus)
%
% each pss is ordered init, ind, mut
    N=length(indss);
    psss=cell(1,N);
    eps=10^(-6);
    for i=1:N
        i
       inds=indss{i};
       l=length(inds);
       %m1=length(rs);
       m2=length(mus);
       pss=zeros(l,l,m2);
       for j=1:l
           for k=1:m2
               %r=rs(j);
               mu=mus(k);
               ps0=zeros(l,1);
               ps0(j)=1;
               pss(j,:,k)=fulldyn(n,inds,r,mu,ps0,0,1,eps,false);            
           end
       end
       psss{i}=pss;
    end
end

