function Rmixed = mixedtensor(n1,n2,indpairs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
l=length(indpairs);
R1=mesatensor(n1);
R2=fulltensor(n2,1:2^n2);
Rmixed=zeros(l,l,l);
for i=1:l
    for j=1:l
        for k=1:l            
            p1=indpairs(i,:);
            p2=indpairs(j,:);
            off=indpairs(k,:);
            Rmixed(i,j,k)=R1(p1(1),p2(1),off(1))*R2(p1(2),p2(2),off(2));
        end
    end
end

end