function [v,lamb] = topeig(A)
%TOPEIG Summary of this function goes here
%   Detailed explanation goes here

%normalized to add to one

[V,D]=eig(A);
m=size(A,1);
diag=D(1:(m+1):m^2);
[lamb,ind]=max(diag);
v=V(:,ind);
v=v/sum(v);
end