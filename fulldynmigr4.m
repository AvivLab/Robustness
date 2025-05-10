function pss = fulldynmigr4(n,inds, subindss, r,mu,migr,ps0,T,mode)
%mode: 0=full, 1=point, 2=diploid
%eps: if nonzero, a threshold for establishing equilibrium
%migr is the migration rate
%in this case ps0 is actually a 2d matrix, l x 2

l=length(inds);
if mode==0
    R=fulltensor(n,inds);
elseif mode==1
    R=pointtensor(n,inds,r);
elseif mode==2
    R=dipointtensor(n/2,inds,r);
    inds=di2flat(inds,n/2); %change to "flat" format for mutation
end

if isscalar(ps0)
    i=ps0;
    ps0=zeros(l,2);
    ps0(i,:)=[1,1];
end

eps = 0.0001;
subinds1=subindss{1};
subinds2=subindss{2};

A=getAdj(2*ones(n,1),0,inds);
ps=ps0;
myT=0;
pss=zeros(T,l,2);
S=[0,1;1,0];
while myT < T
        %noise
        ps = ps.*(ones(l,2)+eps*randn(l,2));

        for x=1:2
            subinds = subindss{x};
            myps=ps(:,x);

            %mutation
            newps = A*myps/n;
            newps = (1-mu)*myps+mu*newps;
            myps(subinds)=newps(subinds);
            mutsum = sum(myps);

            %recombination
            for k = 1:l
                ps(k,x)=(myps'*R(:,:,k)*myps)/mutsum;
            end
        end
        tempps=zeros(l,2);
        tempps(subinds1,1)=ps(subinds1,1);
        tempps(subinds2,2)=ps(subinds2,2);
        ps=tempps;
        %migration
        for k=1:l
            myps =ps(k,:)';
            newps = S*myps;
            ps(k,:)= (1-migr)*myps + migr*newps;
        end
        tempps=zeros(l,2);
        tempps(subinds1,1)=ps(subinds1,1);
        tempps(subinds2,2)=ps(subinds2,2);
        ps=tempps./sum(tempps);
        
    myT=myT+1
    pss(myT,:,:)=ps;
    
    end
end