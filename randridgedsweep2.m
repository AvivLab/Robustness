function [pss,viabless]=randridgedsweep2(n,m,rs,mus,bias,T,inds)
%
%haploid sweep

viabless=cell(1,T);
pss=cell(1,T);
eps=10^(-8);
if isempty(inds)
    inds=cell(1,T);
end
for t=1:T
    t
    [ps,~,~,viableinds,~]=randridged(n,m,rs,mus,bias,false, 0, eps,inds{t},1);
    viabless{t}=viableinds;
    pss{t}=ps;
end
end