function [e,ep] = locexp(t,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
u=t/N;
e=(u - 1).^2./(2*N*u - 2*u - N*u.^2 + u.^2 + 1);
ep=1/N+e*(1-1/N);
end

