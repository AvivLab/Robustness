function qs = getqs(v)
%
%Input: v= vector taking on values from 0 to 1
%
%Output: 1-cdf
%
qs=[1,mean(v>=(1:100)/100)];
end

