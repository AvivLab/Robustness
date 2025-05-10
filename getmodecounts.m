function modecounts = getmodecounts(modes)
%
%counts the number of landscapes whose mode is the given index
%
n=length(modes);  
modecounts=cell(1,n);
m=size(modes{1},1); 
for i=1:n
    l=size(modes{i},2);
    mymodecounts=zeros(m,l);
    for j=1:m
        mymodes=modes{i}(j,:);
        for k=1:l
            mymodecount=sum(mymodes==k);
            mymodecounts(j,k)=mymodecount;
        end
    end
    modecounts{i}=mymodecounts;
end
end

