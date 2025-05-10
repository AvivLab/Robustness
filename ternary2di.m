function [diInds,T] = ternary2di(terInds,n)
%
%terInds (row): indices for a ternary representation of diploid (for sake of viability)
%         1 = 11, 2=12/21, 3=22
%T: a matrix converting between two representations

m=length(terInds);
diInds=[];
T=[];
for j=1:m
    terind=terInds(j);
    tup=ind2tup(3*ones(n,1),terind);
    subTups=[];
    for k=tup'
        l=max(size(subTups,1),1);
        if k==1
            subTups=[subTups,ones(l,1)*[1,1]];
        elseif k==2
            subTups=[subTups,ones(l,1)*[1,2];subTups,ones(l,1)*[2,1]];
        else
            subTups=[subTups,ones(l,1)*[2,2]];
        end
    end
    l=size(subTups,1);
    for i=1:l
        mytup1=subTups(i,1:2:(2*n-1));
        mytup2=subTups(i,2:2:(2*n));
        myind1=tup2ind(2*ones(n,1),mytup1');
        myind2=tup2ind(2*ones(n,1),mytup2');
        diInds=[diInds;myind1,myind2];
    end
    myT=zeros(l,m);
    myT(:,j)=ones(l,1);
    T=[T;myT];
end

end