function inds=  multNKscape(n,k,p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dependencies=zeros(n,k+1);
viabilities=zeros(n,2^(k+1));
inds=[];
for i=1:n
   myperm=randperm(n-1,k);
   myperm(myperm>=i)=myperm(myperm>=i)+1;
   dependencies(i,:)=[i,myperm];
   for j=1:2^(k+1)
      viabilities(i,j)=rand()<p; 
   end
end
for ind=1:2^n
   mytup=ind2tup(2*ones(n,1),ind);
   myviab=true;
   for i=1:n
      subtup=mytup(dependencies(i,:));
      subind=tup2ind(2*ones(k+1,1),subtup);
      myviab = myviab & viabilities(i,subind);
   end
   if myviab
      inds=[inds; ind]; 
   end
end
end

