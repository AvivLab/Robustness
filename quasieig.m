function qe = quasieig(A,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

A=A;
%B=(1-mu)*eye(length(A))+mu/n*A;
C=eye(length(A));
for i=1:k
    C=A*C;
    x=sum(C); 
    C=C./x;
end
%x(x==0)=1;
%B=B./x;
qe=diag(C);
end

