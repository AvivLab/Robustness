function ps= pops2ps(pops,l)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,T]=size(pops);
counts=zeros(l,T);
for t=1:T
    for i=1:n
       myind=pops(i,t);
       counts(myind,t)=counts(myind,t)+1;
    end
end
ps=counts/n;
end

