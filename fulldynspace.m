function pss = fulldynspace(n,inds,r,mu,diff,m,ps0,T,mode)
%mode: 0=full, 1=point, 2=diploid
%eps: if nonzero, a threshold for establishing equilibrium
%diff is the rate of diffusion in space.
%m is the spatial dimension
%in this case ps0 is actually a 2d matrix, l x m^2

l=length(inds);
if mode==0
    R=fulltensor(n,inds);
elseif mode==1
    R=pointtensor(n,inds,r);
elseif mode==2
    R=dipointtensor(n/2,inds,r);
    inds=di2flat(inds,n/2); %change to "flat" format for mutation
end



A=getAdj(2*ones(n,1),0,inds);
S=getAdj([m,m],1,(1:m^2)); %spatial adjacency matrix
S=S./sum(S);

ps=ps0;
myT=0;
pss=zeros(T,l,m^2);
while myT < T
        for x=1:m^2
            %mutation
            myps=ps(:,x);
            newps = A*myps/n;
            myps = (1-mu)*myps+mu*newps;
            mutsum = sum(myps);

            %recombination
            for k = 1:l
                ps(k,x)=(myps'*R(:,:,k)*myps)/mutsum;
            end
        end
        %diffusion
        for k=1:l
            myps =ps(k,:)';
            newps = S*myps;
            ps(k,:)= (1-diff)*myps + diff*newps;
        end
        ps=ps/sum(ps,"all");
    myT=myT+1
    pss(myT,:,:)=ps;
    
end
end