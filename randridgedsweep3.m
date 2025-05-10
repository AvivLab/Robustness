function [pss,viabless]=randridgedsweep3(n,m,rs,mus,bias,T,inds)
%
%Generate random landscapes according to the specified parameters
%For each one, try all initial conditions and record the end results. 

viabless=cell(1,T);
pss=cell(1,T);
eps=0.0001;

for t=1:T
    if isempty(inds)
        myinds=randridgedinds(n,m);
    else
        myinds=inds{t};
    end
    viabless{t}=myinds;
    l=length(myinds);
    %unifrob=avgrob(2*ones(l,1)/l,n,myinds);
    ps=zeros(l,length(mus)*length(rs),l);
    for i=1:l
        i
        ps(:,:,i)=randridged(n,m,rs,mus,bias,false,0,eps,myinds,i);
    end
    pss{t}=ps;
end
end