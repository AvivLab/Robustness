function eigdist = getEigDists(viabless, pss,d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T=length(viabless);
m=size(pss{1},2);
eigdist=zeros(T,m);
for i=1:T
    myinds=viabless{i};
    myeig=topeig(getAdj(2*ones(d,1),0,myinds));
        for k=1:m
            eigdist(i,k)=totalVar(myeig,pss{i}(:,k));
        end
end
end

