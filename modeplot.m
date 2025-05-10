function  modeplot(inds,pops)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ps=pops2ps(pops,length(inds));
l=size(ps,1);
T=size(ps,2);
modes=zeros(1,T);
for t=1:T
    myps=ps(:,t);
    [a,b]=max(myps);
    modes(t)=b;
end
plot(1:T,modes,".-");
end

