function [sups,supsizes] = getSupport(vss,pss)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n=length(vss);
sups=cell(1,n);
supsizes=zeros(1,n);
eps=10^-4;
k=size(pss{1},2);
for i=1:n
   myvs=vss{i};
   myps=pss{i}(:,k);
   mysup=myps>eps;
   sups{i}=myvs(mysup);
   supsizes(i)=length(sups{i});
end

end

