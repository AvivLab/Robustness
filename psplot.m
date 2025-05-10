function psplot(inds,pops,tonorm)

ps=pops2ps(pops,length(inds));
l=size(ps,1);
T=size(ps,2);
dat=zeros(64,T*l,2);
%each bin keeps track of inds with a certain range of ps
counts=zeros(64,1);
figure();
    for t=1:T
        myps=ps(:,t);
        if tonorm
           myps=myps/max(myps); 
        end
        for i=1:l
            bin=floor(myps(i)*63)+1;
            counts(bin)=counts(bin)+1;
            dat(bin,counts(bin),:)=[t;i];
        end
    end
    
    mymap=[ones(64,1),(63:(-1):0)'/63,(63:(-1):0)'/63];
    for bin=2:64
        mycolor=mymap(bin,:);
        mydat=squeeze(dat(bin,1:counts(bin),:));
        if ~isempty(mydat)
            if counts(bin)==1
               mydat=mydat';
            end
            plot(mydat(:,1),mydat(:,2),".",'Color',mycolor);
            hold on
        end
    end 
    colormap(mymap);
    colorbar;
    axis([1,T+1,1,l+1]);
end

