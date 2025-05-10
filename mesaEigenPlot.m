function mesaEigenPlot(n,m1,m2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    w=zeros(m2-m1+1,1);
    A=zeros(m2-m1+1);
    %add m1-1 to k for real index
    for k=2:(m2-m1+1)
        A(k,k-1)=(k+m1-1)/n;
        A(k-1,k)=(n-k-m1+2)/n;
        w(k)=nchoosek(n,k+m1-1);
    end
    w(1)=nchoosek(n,m1);
    v=topeig(A);
    figure();
    plot(m1:m2,v);
    figure()
    plot(m1:m2,v.*w);
end