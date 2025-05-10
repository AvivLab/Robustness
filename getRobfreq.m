rmss=cell(1,50);
for i=1:50
    myinds=viabless{i};
    l=length(myinds);
    rmss{i}=zeros(3,l);
    mus=[0.01,0.05,0.1];
    for j=1:l
        for k=1:3
            [ps,rrs,rms]=fulldyn(10,myinds,0.1,mus(k),pss{i}(:,k,j),1,1,0);
            rmss{i}(k,j)=rms;
        end
    end
end