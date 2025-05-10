function [distss,robmss,robrss,viabless]=randridgedsweep1(n,m,rs,mus,bias,T,inds)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

distss=[];
robmss=[];
robrss=[];
viabless=cell(1,T);
eps=0.01;
if isempty(inds)
    inds=cell(1,T);
end
for t=1:T
    [vs,robms,robrs,viableinds]=randridged(n,m,rs,mus,bias,false,eps,inds{t});
    v0=vs(:,1);
    l=size(vs,2);
    dists=zeros(1,l-1);
    for i=2:l
        dists(i-1)=totalVar(v0,vs(:,i));
    end
    distss=[distss;dists];
    robmss=[robmss;robms];
    robrss=[robrss;robrs];
    viabless{t}=viableinds;
end

%plot(dists);
%hold on
%plot(robms);
end