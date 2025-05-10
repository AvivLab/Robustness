function B = getFullAdj(ns,mode)
%GETADJ Summary of this function goes here
%   Detailed explanation goes here
    N=prod(ns);
    B=zeros(N);
    for i=1:N
        for j=getNeighbs(ns,i,mode)
            B(i,j)=1;
        end
    end

end