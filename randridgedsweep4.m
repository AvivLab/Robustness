function [pss,viabless,ternss]=randridgedsweep4(n,m,rs,mus,bias,T,inds,mode)
%
%Generate random diploid landscapes according to the specified parameters


viabless=cell(1,T);
ternss=cell(1,T);
pss=cell(1,T);
eps=0.001;
if isempty(inds)
    inds=cell(1,T);
end
for t=1:T
    t
    [ps,~,~,viableinds,terninds]=randridged(n,m,rs,mus,bias,false, mode, eps,inds{t},1);
    viabless{t}=viableinds;
    ternss{t}=terninds;
    pss{t}=ps;
end
end