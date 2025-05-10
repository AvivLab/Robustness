function [dv,ndv] = degvar(ns,inds,mode)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
A=getAdj(ns,mode,inds);
l=length(inds);
degs=A*ones(l,1);
dv=var(degs);
ndv=dv/mean(degs);
    
end

