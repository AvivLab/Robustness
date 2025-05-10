function [v,lamb,counts]=major(n,toplot)
%MAJOR Summary of this function goes here
%   Detailed explanation goes here

m=ceil(n/2);
A=zeros(n-m+1);
counts=zeros(n-m+1,1);
counts(1)=nchoosek(n,m);
%add m-1 to k for real index
for k=2:n-m+1
   A(k,k-1)=k+m-1;
   A(k-1,k)=n-k-m+2;
   counts(k)=nchoosek(n,k+m-1);
end
[v,lamb]=topeig(A);
if toplot
   plot(v) 
end


end