function [avgEigs, normAvgEigs] = avgeigcent(indss,n,pss)
%calculate the average/normalized average eigen-centrality of this population distribution
%can be done for either haploid or diploid
    T=length(pss);
    k=size(pss{1},2);
    d=min(size(indss{1}));
    avgEigs=zeros(T,k);
    normAvgEigs=zeros(T,k);
    m=d*n;
    for i=1:T
        myinds=indss{i};
        if d==2
            myinds=di2flat(myinds,n);
        end
        A=getAdj(2*ones(m,1),0,myinds);
        eig=topeig(A);
        for j=1:k
            myps=pss{i}(:,j);
            avgEigs(i,j)=eig'*myps;
            normAvgEigs(i,j)=(eig'*myps)/(eig'*eig);
        end
    end 
end