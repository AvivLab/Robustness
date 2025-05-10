function indpairs = narrowpathinds(m1,m2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n2=m2-1;
l=2^m1+2^(m2-1)+(m2-m1-1);
indpairs=zeros(l,2);
count=1;
S=getsubsets(n2);
for i=1:(2^n2)
    myset=S(i,:);
    k=sum(myset);
    mytup=myset+1;
    myind=tup2ind(n2,2*ones(n2,1),mytup');
    if k<=m2
        d2=m2-k;
        indpairs(count,:)=[d2+1,myind];
        count=count+1;
    end
    if k<=m1
        d1=m1-k;      
        indpairs(count,:)=[d1+1,myind];
        count=count+1;  
    end
end

for k=(m1+1):n2
    mytup=[2*ones(1,k),ones(1,n2-k)];
    myind=tup2ind(n2,2*ones(n2),mytup');
    indpairs(count,:)=[1,myind];
    count=count+1;
end

end