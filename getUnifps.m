unifps=cell(1,50);
for i=1:50
    myinds=viabless{i};
    l=length(myinds);
    unifps{i}=zeros(3,l);
    for k=1:3
        unifps{i}=randridged(10,12,0.1,[0.01,0.05,0.1],0,false,0.01,myinds,1);
    end
end