function [sl,nsl] = simploc(p)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    if size(p,1) == 1
       p=p';
    end
    sl=p'*p;
    nsl=sl*(length(p));
end

