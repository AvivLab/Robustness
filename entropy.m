function e= entropy(v)
%v a column vector
    v=v(v>0);
    n=length(v);
    e=-v'*log(v)/log(n);
    %e=-v'*log(v);
end