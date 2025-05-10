function path = randminpath(n,d,ind1,ind2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

tup1=ind2tup(d*ones(n,1),ind1)';
tup2=ind2tup(d*ones(n,1),ind2)';
diff=1:n;
diff=diff(tup1~=tup2);
l=length(diff);
perm=randperm(l,l);
diff=diff(perm);
%path=ones(l+1,1)*tup1;
path=tup1;
curpath=path;
for i=1:l
    j=diff(i);
    if tup1(j)<tup2(j)
        mypath=(tup1(j)+1):tup2(j);
    else
        mypath=(tup1(j)-1):-1:tup2(j);
    end
    l=length(mypath);
    subpath=ones(l,1)*curpath;
    subpath(:,j)=mypath';
    curpath(j)=tup2(j);
    path=[path;subpath];
end


end