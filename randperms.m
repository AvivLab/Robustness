function vss = randperms(vs,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[l,d]=size(vs);
vss=cell(1,k);
for i=1:k
   myvs=zeros(l,d);
   myperm=randperm(l);
   for j=1:d
      myvs(:,j)=vs(myperm,j); 
   end
   vss{i}=myvs;
end
end

