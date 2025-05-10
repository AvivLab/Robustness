function maxfreqs = getMaxFreqs(vs,pss,d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n=length(vs);
m=size(pss{1},2);
maxfreqs=zeros(n,m);
eps=0.0001;
normeigs=cell(1,n);
modes=cell(1,n);
for i=1:n
   myeigs=topeig(getAdj(2*ones(d,1),1,vs{i}));
   normeigs{i}=myeigs/max(myeigs);
   l=size(pss{i},3);
   mymodes=zeros(m,l);
   for j=1:m
       for k=1:l
           myps=pss{i}(:,j,k);
           [~,mymode]=max(myps);
           mymodes(j,k)=mymode;
       end
   end
   modes{i}=mymodes;
end
maxfreqs=zeros(n,m);
for i=1:n
    for j=1:m
        maxfreqs(i,j)=mean(normeigs{i}(modes{i}(j,:))>1-eps);
    end
end
end

