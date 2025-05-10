function B = getAdjSemi(ns,mode,inds,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%  mode=0 : "genetic" -- jump anywhere along a fixed dimension
%  mode=1 : "geometric" -- only adjacent
%  mode=2 : torus -- geometric with wraparound
%  mode=3 : diploid 

%t: "discounting" factor
    N=prod(ns);
    l=length(inds);
    B=zeros(N);
    indmap=containers.Map(inds,1:l);
    % maps "true" ind to relative ind within inds
    for i=1:N
        x=1;
        if ~isKey(indmap,i)
         x = t;
        end
        % ind=inds(i);
        for j=[i,getNeighbs(ns,i,mode)]
            y=x;
            if ~isKey(indmap,j)
                y = x * t;
            end
            B(i,j)=y;
        end
    end

end