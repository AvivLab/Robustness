unifrmss=zeros(3,50);
for i=1:50
    myinds=viabless{i};
    l=length(myinds);
    mus=[0.01,0.05,0.1];
    for k=1:3
        [ps,rrs,rms]=fulldyn(10,myinds,0.1,mus(k),unifps{i}(:,k),1,1,0);
        unifrmss(k,i)=rms;
    end
end