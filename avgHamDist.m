function meand = avgHamDist(ns,pop1,pop2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
totd=0;
for i=pop1
    for j=pop2
        x=ind2tup(ns,i);
        y=ind2tup(ns,1);
        d=sum(abs(x-y));
        totd=totd+d;
    end
end
meand=totd/(length(pop1)*length(pop2));
end

