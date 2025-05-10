function R = pointtensor(d,inds,r)
%
%The recombination tensor for d-dim hypercube, using uniform one-point crossover
%
%R(i,j,k) is the probability of parents i,j having offspring k

   l=length(inds);
   ns=2*ones(d,1);
   R=zeros(l,l,l);
   R0=zeros(l,l,l);
   for i=1:l
       for j=1:l
           R0(i,j,i)=R0(i,j,i)+1/2;
           R0(i,j,j)=R0(i,j,j)+1/2;
           x=ind2tup(ns,inds(i))';
           y=ind2tup(ns,inds(j))';
           for m=1:(d-1)
               myset=[ones(1,m),zeros(1,d-m)];
               offspring=x.*myset+y.*(1-myset);
               myind=tup2ind(ns,offspring');
               k=find(inds==myind,1);
               if ~isempty(k)
                   R(i,j,k)=R(i,j,k)+1;
                   R(j,i,k)=R(j,i,k)+1;
               end              
           end
       end
   end
   R=R/(2*(d-1));
   R=(1-r)*R0+r*R;

end