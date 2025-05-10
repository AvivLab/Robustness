function [viabInds] = getdirandgrid(ns,p)
%GETRANDGRID produces Russian-Roulette random grid
%   ns a vector of the dimensions of the grid
%   p the probability of deleting each node
%   viabInds a list of viable pairs of indices.
    N=prod(ns);
    viabInds=[];

    for i=1:N
        for j=i:N
           if rand()>p
                viabInds=[viabInds;[i,j]];
                if j>i
                    viabInds=[viabInds;[j,i]];
                end
           end
        end
    end

end
