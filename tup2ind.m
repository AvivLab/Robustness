function ind = tup2ind(ns,tup)
%tup,ns are column vectors
%assigns an index from 1 to prod(ns) for each d-tuple
    d=length(ns);
    multipliers=ones(1,d);
    for i=2:d
       multipliers(i)=multipliers(i-1)*ns(i-1);
    end
    ind=multipliers*(tup-1)+1;
end