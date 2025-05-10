function ps= pops2totps(pops,l)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,T]=size(pops);
counts=zeros(l,1);
for t=1:T
    for i=1:n
       myind=pops(i,t);
       counts(myind)=counts(myind)+1;
    end
end
ps=counts/(T*n);
end

