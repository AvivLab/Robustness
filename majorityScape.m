function [ output_args ] = majorityScape(ns,p,q)
%MAJORITYSCAPE Summary of this function goes here
%   ns a vector of dimensions
%   p the probability of each allele being a 0
    N=prod(ns);
    d=length(ns);
    contributions=cell(d,1);
    for j=1:d
        n=ns(j);
        myContr=ones(1,n);
        for i=1:n
           if rand()<p
               myContr(i)=0;
           end
        end
        contributions{j}=myContr;
    end
    
    for i=1:N
       totContr=0;
       tup=ind2tup(d,ns,i);
       for j=1:d
          totContr=totContr+contributions{j}(tup(j));
       end
       if totContr/d>=q
           
       end
    end


end