function R = dipointtensor(n,diInds,r)
%
%Assume diInds is lx2
    
   l=size(diInds,1);
   [inds,indmap]=merge(diInds); %gets the gamete inds
   R1=pointtensor(n,inds,r); %gamete tensor
   R=zeros(l,l,l);
   for i=1:l
       for j=1:l
           for k=1:l
               i1=indmap(i,1); i2=indmap(i,2);
               j1=indmap(j,1); j2=indmap(j,2);
               k1=indmap(k,1); k2=indmap(k,2);
               p1=R1(i1,i2,k1);
               p2=R1(j1,j2,k2);
               R(i,j,k)=p1*p2;
           end
       end
   end

end

