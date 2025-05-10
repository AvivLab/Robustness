function pss = fulldynmigr3(n,inds,r,mu,eps,ps0,T,mode)
%mode: 0=full, 1=point, 2=diploid
%eps: amount of noise
%migr is the migration rate
%in this case ps0 is actually a d matrix, l x m
%this allows for m different populations.

l=length(inds);
if mode==0
    R=fulltensor(n,inds);
elseif mode==1
    R=pointtensor(n,inds,r);
elseif mode==2
    R=dipointtensor(n/2,inds,r);
    inds=di2flat(inds,n/2); %change to "flat" format for mutation
end

m=size(ps0,2);

A=getAdj(2*ones(n,1),0,inds);
ps=ps0;
myT=0;
pss=zeros(T,l,m);

while myT < T
        for x=1:m

            %noise
            ps = ps.*(ones(l,m)+eps*randn(l,m));

            %mutation
            myps=ps(:,x);
            newps = A*myps/n;
            myps = (1-mu)*myps+mu*newps;

            %recombination
            for k = 1:l
                ps(k,x)=(myps'*R(:,:,k)*myps);
            end
        end
        ps = ps./sum(ps);
    myT=myT+1;
    pss(myT,:,:)=ps;
    
end
end