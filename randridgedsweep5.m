function struct=randridgedsweep5(n,m,rs,mus,bias,T,inds,mode)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
viabless=cell(1,T);
pss=cell(1,T);
eps=0.0001;
if isempty(inds)
    inds=cell(1,T);
end
for t=1:T
    [ps,~,~,viableinds,terninds]=randridged(n,m,rs,mus,bias,false,mode,eps,inds{t},1);
    viabless{t}=viableinds;
    pss{t}=ps;
    ternss{t}=terninds;
end
struct={viabless,pss,ternss};
%plot(dists);
%hold on
%plot(robms);
end