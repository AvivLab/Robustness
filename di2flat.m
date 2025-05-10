function inds = di2flat(diInds,n)
%converts from two-gamete formate to one gamete double the length
%n = dim of each gamete
    inds=diInds(:,1)+2^n*(diInds(:,2)-1);
end