function R=fulltensor(d,inds)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   S=getsubsets(d);
   ns=2*ones(1,d);
   N=2^d;
   l=length(inds);
   R=zeros(l,l,l);
   for i=1:l
       for j=1:l
           x=ind2tup(ns,inds(i))';
           y=ind2tup(ns,inds(j))';
           for m=1:N
               myset=S(m,:);
               offspring=x.*myset+y.*(1-myset);
               myind=tup2ind(ns,offspring');
               k=find(inds==myind,1);
               if ~isempty(k)
                   R(i,j,k)=R(i,j,k)+1;
               end              
           end
       end
   end
   R=R/N;
end