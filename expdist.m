function ed = expdist(ns,inds,v)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    D=getDistMat(ns,inds);
    ed=v'*D*v;
    ned=ed/length(v);
end

