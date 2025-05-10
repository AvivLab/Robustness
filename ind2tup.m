function tup = ind2tup(ns,ind)
%IND2TUP 
%
%

d=length(ns);
ind=ind-1;
tup=zeros(d,1);
for i=1:d
    myn=ns(i);
    myind=mod(ind,myn);
    tup(i)=myind+1;
    ind=(ind-myind)/myn;
end


end