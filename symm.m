function S = symm(M)
%SYM Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M);
np=n*(n+1)/2;
mp=m*(m+1)/2;
T=tensor(M,M);
S=zeros(np,mp);
ind1=0;
for i=1:n
    for j=i:n
        ind1=ind1+1;
        ind2=0;
        for k=1:m
            for l=k:m
                ind2=ind2+1;
                entry=M(i,k)*M(j,l);
                if j~=i
                   entry=entry+M(j,k)*M(i,l); 
                end
                S(ind1,ind2)=entry;
            end
        end
    end
end

end