function B = neutralDrift(N,nu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%Assume nu significantly smaller than 1/N. 
%For simplicity, we assume that there is at most one mutation per locus in
%entire population.
A=zeros(N+1); %matrix with sampling only
B=zeros(N+1); %matrix with sampling and mutation

A(1,1)=1;
A(N+1,N+1)=1;
for i=2:N
    for j=1:(N+1)
        A(j,i)=binopdf(j-1,N,(i-1)/N);
    end
end

B(1,1)=1-N*nu;
B(2,1)=N*nu;
B(N,N+1)=N*nu;
B(N+1,N+1)=1-N*nu;

for i=2:N
    for j=2:N
        B(j,i)=(1-N*nu)*A(j,i)+(N-j+2)*nu*A(j-1,i)+(j)*nu*A(j+1,i);
    end
    B(1,i)=(1-N*nu)*A(1,i)+nu*A(2,i);
    B(N+1,i)=(1-N*nu)*A(N+1,i)+nu*A(N,i);
end
end