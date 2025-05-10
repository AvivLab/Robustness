function w = mutate(d,v,mu)
%MUTATE Summary of this function goes here
%   Detailed explanation goes here
N=2^d;
ns=2*ones(1,d);
B=getFullAdj(ns,0);
M=eye(N)*(1-mu)+B*mu/d;
w=M*v;
end