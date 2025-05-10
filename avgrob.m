function r = avgrob(v,n,inds)
    A=getAdj(2*ones(n,1),0,inds);
    r=sum(A*v);
end