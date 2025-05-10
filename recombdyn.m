function [ps,rob] = recombdyn(d,r,mu,ps0,T,viableinds)
%performs recombination: d locus, 2 alleles each
%randomly chooses one recombination event
ps=ps0/sum(ps0);
ns=2*ones(1,d);
N=2^d;
rob=[];
for t=1:T
   newps=zeros(N,1);
   for i=1:N
       for j=1:i
           x=ind2tup(d,ns,i)';
           if j<i
               mult=2;
               y=ind2tup(d,ns,j)';
           else
              mult=1;
              y=x; 
           end
           myvec=recomb(x,y,r);
           myp=mult*ps(i)*ps(j);
           newps=newps+myp*myvec;
       end
   end
   ps=zeros(N,1);
   ps(viableinds)=newps(viableinds);
   newps=mutate(d,ps,mu);
   ps=zeros(N,1);
   ps(viableinds)=newps(viableinds);
   rob=[rob,sum(ps)];
   ps=ps/sum(ps);
end
plot(rob);
end