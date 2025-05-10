function [mu,delta] = getci(v,a)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n=length(v);
mu=mean(v);
s=std(v);
x = norminv(1-a/2);
delta=x*s/sqrt(n);
end

