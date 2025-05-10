function [mesasls,mesansls]  = mesasl(ns,kmax)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
mesasls=zeros(length(ns),kmax+1);
mesansls=zeros(length(ns),kmax+1);
for n=ns
    A=mesaAdj(n);
    nchoose=zeros(1,31);
    for k=0:kmax
        myA=A(1:k+1,1:k+1);
        myv=topeig(myA);
        nchoose(k+1)=nchoosek(n,k);
        mychoose=nchoose(1:k+1);
        myweightedsum=sum(myv.*mychoose');
        mycount=sum(mychoose);
        myv=myv/myweightedsum;
        sl= mychoose*(myv.^2);
        mesasls(n-ns(1)+1,k+1)=sl;
        mesansls(n-ns(1)+1,k+1)=sl*mycount;
    end
end
end

