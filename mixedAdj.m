function Amixed = mixedAdj(n1,n2,indpairs)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    A1=mesaAdj(n1);
    A2=getFullAdj(2*ones(n2,1),0);
    l=length(indpairs);
    Amixed=zeros(l,l);
    for i=1:l
        for j=1:l
            pair1=indpairs(i,:);
            pair2=indpairs(j,:);
            if pair1(1)==pair2(1)
               Amixed(i,j)=A2(pair1(2),pair2(2));    
            elseif pair1(2)==pair2(2)
               Amixed(i,j)=A1(pair1(1),pair2(1)); 
            end
            
        end
    end

end