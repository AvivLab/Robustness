function [B,vtop,lambda,viablepairs]= randgridhidim(ns,p)
%Creates an nxn grid, where each point has a probability p of being removed.
%Calculate the resulting stationary distribution of evolutionary dynamics
%Matrix A will record viability of each point (0/1).
%Matrix B will record the adjacency matrix among viable nodes.
N=prod(ns);
A=ones(ns);
B=zeros(N);
viables=[];
viablepairs=[];
d=length(ns);
deg=sum(ns-1);

for i=1:N
   tup=ind2tup(d,ns,i);
   neighbs=getneighbinds(tup,i,ns);
   for neighb = neighbs
       B(i,neighb)=1; 
   end
   if rand()<p
        A(i)=0;
   else
        viables=[viables,i];
        viablepairs=[viablepairs;ind2tup(d,ns,i)'];
   end
end

B=B(viables,viables);
m=size(viables,2);
[V,D]=eig(B);
diagonal=zeros(1,m);
for i=1:m
   diagonal(i)=D(i,i); 
end
[diagonal,ind]=sort(diagonal);
V=V(:,ind);
lambda=diagonal(m);
%t=200;
%V=(sparse(B)^t)*ones(m,1);
vtop=V(:,m)/sum(V(:,m));
%ls=(eye(m)-B/deg)\(ones(m,1));
%ls=ls/sum(ls);

end

function neighbs = getneighbinds(tup,ind,ns)
    d=length(ns);
    neighbs=[];
    multipliers=ones(1,d);
    for i=2:d
       multipliers(i)=multipliers(i-1)*ns(i-1);
    end
    for i=1:d
       if tup(i)>1
           neighbs=[neighbs,ind-multipliers(i)];
       end
       if tup(i)<ns(i)
           neighbs=[neighbs,ind+multipliers(i)];
       end
    end
end
