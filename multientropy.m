function e = multientropy(v,counts)
%MULTIENTROPY Summary of this function goes here
%   Detailed explanation goes here
    pos=(v>0);
    v=v(pos);
    counts=counts(pos);
    tot=counts'*v;
    v=v/tot;
    n=sum(counts);
    e=-(counts.*v)'*log(v)/log(n);

end