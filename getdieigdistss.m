function eigdists = getdieigdistss(distruct)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
viabless=distruct{1};
pss=distruct{2};
ternss=distruct{3};
l=length(viabless);
m=size(pss{1},2);
eigdists=zeros(l,m);
for i=1:l
    diInds=viabless{i};
    flatInds=di2flat(diInds,5);
    for k=1:m
        eigdists(i,k)=totalVar(topeig(getAdj(2*ones(10,1),0,flatInds)),pss{i}(:,k));
    end
    
end
end