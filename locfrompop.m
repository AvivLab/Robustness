function sl = locfrompop(v)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
l=length(v);
counts=containers.Map('KeyType','int64', 'ValueType','uint8');
n=0;
for i =v'
   if isKey(counts,i)
       counts(i)=counts(i)+1;
   else
      counts(i)=1;
      n=n+1;
   end
end
ps=zeros(n,1);
mykeys=keys(counts);
for i= 1:length(mykeys)
   mycount=double(counts(mykeys{i}));
   ps(i)=mycount/l;
end
sl=ps'*ps;
end

