function viablepairs=randomwalkgrid(n,T)
%CONTIGRANDGRID Summary of this function goes here
%   Detailed explanation goes here
    curpair=[n/2,n/2];
    N=n^2;
    viablepairs=[];
    for t=1:T
        viablepairs=[viablepairs;curpair];
        myind=tup2ind(2,[n,n],curpair');
        myneighbs=getNeighbs([n,n],myind,1);
        l=length(myneighbs);
        nextind=myneighbs(ceil(rand()*l));
        curpair=ind2tup(2,[n,n],nextind)';
    end
plotgrid(n,viablepairs,ones(1,length(viablepairs)));
end

function boo= isvalid(pair,n)
    boo= (pair(1)>0 & pair(1)<= n & pair(2)>0 & pair(2)<=n);
end