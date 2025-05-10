function Rmod = modtensor(n,rs,inds,mode)

%mode: 0="full", 1="point"
%rs = a vector of 3 values of recombination rates (for 00, 01, and 11)
l=length(inds);
indpairs=[ones(l,1),(1:l)';2*ones(l,1),(1:l)'];
indsplus=[inds;inds+2^n];
if mode==0
    R=fulltensor(n+1,indsplus);
elseif mode==1
    R=pointtensor(n+1,indsplus);
end
ll=2*l;
Rmod=zeros(ll,ll,ll);
for i=1:ll
    for j=1:ll
        for k=1:ll            
            p1=indpairs(i,:);
            p2=indpairs(j,:);
            rind=p1(1)+p2(1)-1;
            myr=rs(rind);
            Rmod(i,j,k)=(1-myr)*((i==k)+(j==k))/2+myr*R(i,j,k);
        end
    end
end

end