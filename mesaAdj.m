function A = mesaAdj(n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    A=zeros(n+1);
    %subtract 1 from k for real index
    for k=2:(n+1)
        A(k,k-1)=(k-1);
        A(k-1,k)=(n-k+2);
    end
end