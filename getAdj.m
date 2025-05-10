function B = getAdj(ns,mode,inds)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%  mode=0 : "genetic" -- jump anywhere along a fixed dimension
%  mode=1 : "geometric" -- only adjacent
%  mode=2 : torus -- geometric with wraparound
%  mode=3 : diploid 
    l=length(inds);
    B=zeros(l);
    if l==0
        return
    end
    indmap=containers.Map(inds,1:l);
    for i=1:l
        ind=inds(i);
        for neighbind=getNeighbs(ns,ind,mode)
            if isKey(indmap,neighbind)
                j=indmap(neighbind);
                B(i,j)=1;
            end          
        end
    end

end