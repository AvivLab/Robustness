function eigcent(n,ks)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
A=zeros(n);
for i=2:n
   A(i-1,i)=1;
   A(i,i-1)=1;
end
[v,d]=eig(A);
plot(1:n,v(:,n)/sum(v(:,n)),'.r')
v4=sin(pi*(1/(n+1):1/(n+1):(1-1/(n+1))));
hold on
plot(1:n,v4/sum(v4),'.b')
for k=ks
    hold on;
    rk=A^k*ones(n,1);
    plot(1:n,rk/sum(rk))
end

end

