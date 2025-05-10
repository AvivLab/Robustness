function eigcent2(n,mu,del)
%The network will have 3*n nodes, divided into 
%three segments of n nodes, with fitnesses (1+del),1,(1+del)
%mu=rate of mutation
m=3*n;
F=zeros(m);
A=zeros(m);
%Ap=zeros(n);
%diag=[(1+del)*ones(1,n),ones(1,n),(1+del)*ones(1,n)];
diag=1-sin((1:m)*pi/(m+1));
for i=1:m
    F(i,i)=diag(i);
end
for i=2:m
   A(i-1,i)=1;
   A(i,i-1)=1;
end
%for i=2:n
%   Ap(i-1,i)=1;
%   Ap(i,i-1)=1;
%end

B=(1-mu)*F+(mu/2)*A*F;
[vtop,lamb]=topeig(B)
vtopr=vtop(m:-1:1);
vtopa=(vtop+vtopr)/2;
plot(vtopa)
%[~,ind]=max(vtopa);
%sintest=sin(pi/(2*ind)*(1:(2*ind-1)));
%sintest=sintest*(vtopa(ind)/sintest(ind));
%plot(1:(2*ind-1),vtopa(1:(2*ind-1)))
%hold on
%plot(1:(2*ind-1),sintest)


end