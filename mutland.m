function [pss,inds,subindss] = mutland(n,p,p1,p2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %p1 = only 1, p2 = only 2

    %start by getting a landscape, take connected component. Only then do
    %the rest.
    ns=2*ones(1,n);
    inds = getrandgrid(ns,p);
    inds=getConncomp(ns,inds,0);

    %now distribute into 1,2,3.

    subinds1=[];
    subinds2=[];
    l = length(inds);
    for i = 1 : l
        if rand() < p1     
            subinds1=[subinds1, i];
        elseif rand() < p1+p2
            subinds2=[subinds2, i];
        else
            subinds1=[subinds1, i];
            subinds2=[subinds2, i];
        end
    end
    subindss=cell(1,2);
    subindss{1}=subinds1;
    subindss{2}=subinds2;
    %now carry out the dynamics, with masking.
    testps=zeros(l,2);
    testps(1,1)=1; testps(l,2)=1;
    pss=fulldynmigr4(n,inds,subindss,0.1,0.0001,0.0001,testps,10000,1);
end