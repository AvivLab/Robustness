function s=weightedsum(v)
    n=length(v)-1;
    weights=zeros(1,n+1);
    for k=0:n
       weights(k+1)= nchoosek(n,k);
    end
    s=weights*v;
end