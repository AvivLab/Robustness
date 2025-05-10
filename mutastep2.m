function [w,rob]=mutastep2 (v,ms)
    n=length(v)-1;
    %assume weightedsum(v)=1
    %v=v/weightedsum(v);
    A=zeros(n+1);
    for k=2:(n+1)
        A(k,k-1)=(k-1)/n;
        A(k-1,k)=(n-k+2)/n;
    end
    v=A*v;
    w=zeros(n+1,1);
    for i=ms
        w(i+1)=v(i+1);
    end
    rob=weightedsum(w);
end