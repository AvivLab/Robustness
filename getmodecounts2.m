function modecounts2 = getmodecounts2(modecounts)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
n=length(modecounts);
m=size(modecounts{1},1);
modecounts2=zeros(n,m);
for i=1:n
   mymodecounts=modecounts{i}; 
   modecounts2(i,:)=sum(mymodecounts'>0);
end

end

