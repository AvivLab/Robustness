function M = tensor(M1,M2)
%TENSOR Summary of this function goes here
%   Detailed explanation goes here
s1=size(M1);
s2=size(M2);
sz=s1.*s2;
M=zeros(sz);

for i=1:s1(1)
   for j=1:s1(2)
       M(((i-1)*s2(1)+1):(i*s2(1)),((j-1)*s2(2)+1):(j*s2(2)))=M1(i,j)*M2;
   end
end

end