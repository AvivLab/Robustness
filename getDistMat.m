function D = getDistMat(ns,inds)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
l=length(inds);
    D=zeros(l);
    for i=1:l
        tup1=ind2tup(ns,i);
        for j=i:l
            tup2=ind2tup(ns,j);
            d=sum(tup1~=tup2); 
            D(i,j)=d;
            D(j,i)=d;
        end
    end
end

