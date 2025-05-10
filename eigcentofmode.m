function [modeEigs, normModeEigs] = eigcentofmode(indss,n,pss)
%calculate the eigen-centralities of the modes of the population
%distributions
    T=length(pss);
    k=size(pss{1},2);
    d=size(indss{1},2);
    modeEigs=zeros(T,k);
    normModeEigs=zeros(T,k);
    m=d*n;
    for i=1:T
        i
        myinds=indss{i};
        if d==2
            myinds=di2flat(myinds,n);
        end
        A=getAdj(2*ones(m,1),0,myinds);
        eig=topeig(A);
        for j=1:k
            j
            myps=pss{i}(:,j);
            [~,myind]=max(myps);
            modeEigs(i,j)=eig(myind);
            normModeEigs(i,j)=eig(myind)/max(eig);
        end
    end 
end