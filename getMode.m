modes=cell(1,50);
for i=1:50
    myinds=viabless{i};
    l=length(myinds);
    modes{i}=zeros(3,l);
    for j=1:l
        for k=1:3
            [a,b]=max(pss{i}(:,k,j));
            modes{i}(k,j)=b;
        end
    end
end