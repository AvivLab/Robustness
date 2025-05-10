eigdist2=cell(1,50);
for i=1:50
    myinds=viabless{i};
    l=length(myinds);
    eigdist2{i}=zeros(1,13);
        for k=1:13
            eigdist2{i}(k)=totalVar(topeig(getAdj(2*ones(10,1),0,myinds)),ps{i}(:,k));
        end
end