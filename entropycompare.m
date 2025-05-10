function  entropycompare(params,mode,r,mu,trials)
%mode: 0 = randridged, params=[n,m]
if mode==0
    n=params(1); m=params(2);
    e1=zeros(1,trials);
    e2=zeros(1,trials);
    for t=1:trials
        inds=randridgedinds(n,m);
        l=length(inds);
        ps=fulldyn(n,inds,0,1,ones(l,1),1000);
        ps2=fulldyn(n,inds,r,mu,ps,5000);
        e1(t)=entropy(ps);
        e2(t)=entropy(ps2);
    end
end

plot(e1,e2);

end