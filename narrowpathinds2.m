function indpairs = narrowpathinds2(m,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n2=m-1;
n1=n-n2;
indpairs=[];
S=getsubsets(n2);
for i=1:(2^n2)
    myset=S(i,:);
    k=sum(myset);
    mytup=myset+1;
    myind=tup2ind(n2,2*ones(n2,1),mytup');
    d=m-k;
    for l=d:n1
        indpairs=[indpairs;l+1,myind];
    end
end

for k=0:n2
    mytup=[2*ones(1,k),ones(1,n2-k)];
    myind=tup2ind(n2,2*ones(n2),mytup');
    indpairs=[indpairs;1,myind];
end

end