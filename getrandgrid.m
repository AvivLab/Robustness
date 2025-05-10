function [viabInds,viabTups,A] = getrandgrid(ns,p)
%GETRANDGRID produces Russian-Roulette random grid
%   ns a vector of the dimensions of the grid
%   p the probability of deleting each node
%   viabInds a list of viable indices
%   viabTups a list of viable d-tuples, d=length(ns)
    N=prod(ns);
    A=ones(ns);
    viabInds=[];
    viabTups=[];

    for i=1:N
       tup=ind2tup(ns,i);
       if rand()<p
            A(i)=0;
       else
            viabInds=[viabInds,i];
            viabTups=[viabTups;tup'];
       end
    end

end
