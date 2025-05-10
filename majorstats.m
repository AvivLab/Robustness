function  majorstats(n1,n2)
%MAJORSTATS Summary of this function goes here
%   Detailed explanation goes here
    es=zeros(1,n2-n1+1);
    rhos=zeros(1,n2-n1+1);
    for n=n1:n2
       [v,lamb,counts]=major(n,false);
       i=n-n1+1;
       es(i)=multientropy(v,counts);
       rhos(i)=lamb/n;
    end
    plot(n1:n2,es);
    hold on;
    plot(n1:n2,rhos);
    hold off
end