function ternInds = bi2domtern(biInds,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ternInds=[];
for biInd = biInds'
    tup=ind2tup(2*ones(n,1),biInd);
    subTups=[];
    for k=tup'
        l=max(size(subTups,1),1);
        if k==1
            %add 00, which in ternary is 1
            subTups=[subTups,ones(l,1)];
        elseif k==2
            %add 10,01,11, which in ternary is 2,3
            subTups=[subTups,ones(l,1)*2;subTups,ones(l,1)*3];
        end
    end
    for i=1:size(subTups,1)
        mytup=subTups(i,:);
        myind=tup2ind(3*ones(n,1),mytup');
        ternInds=[ternInds;myind];
    end
end
end