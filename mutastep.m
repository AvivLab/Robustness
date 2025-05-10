function [w,rob]=mutastep (v,m1,m2)
    n=length(v)-1;
    %assume weightedsum(v)=1
    %v=v/weightedsum(v);
    w=zeros(n+1,1);
    A=zeros(m2-m1+1);
    %add m1-1 to k for real index
    for k=2:(m2-m1+1)
        A(k,k-1)=(k+m1-1)/n;
        A(k-1,k)=(n-k-m1+2)/n;
    end
    w((m1+1):(m2+1))=A*(v((m1+1):(m2+1)));
    rob=weightedsum(w);
end