function [indsss,vss] = russiansweep(ns,ps,T, mode,d, minsize,maxsize)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%mode =0: d^n genetic
%mode =1: n^d geometric
%ns: a vector of different values of n to sweep through
%ps: a vector of different values of p to sweep through
% where each p is probability of being inviable
%T: number of samples from each set of parameters
%minsize,maxsize : constraints on size of connected component

%note, original version had only the first 4 inputs
%minsize and maxsize not currently used, but can be by uncommenting
%lines 38,41


k=length(ns);
l=length(ps);
indsss=cell(k,l);
vss=cell(k,l);
for i=1:k
    i
    for j=1:l
        j
        n=ns(i);
        if mode==0
            myns=d*ones(1,n);
        else
            myns=n*ones(1,d);
        end
        p=ps(j);
        indss=cell(1,T);
        vs=cell(1,T);
        t=1;
        while t<=T
            inds=getrandgrid(myns,p);
            inds=getConncomp(myns,inds,mode);
            sze = length(inds);
            if minsize == 0 || (sze >= minsize && sze <= maxsize)
                indss{t}=inds;
                A = getAdj(myns,mode,inds);
                v=topeig(A);
                vs{t}=v;
                t=t+1;
            end

        end
        indsss{i,j}=indss;
        vss{i,j}=vs;
    end
end


end

