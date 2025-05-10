function inds = getAddDiScape(n, thresh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N=2^n;
w1 = rand(1,N);
w2 = rand(1,N);
inds = zeros(N,2);

for i = 1:N
    for j = 1:N
        if w1(i)+w2(j) > thresh
            inds = [inds; i, j];
        end
    end
end
end