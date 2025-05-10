function viableinds = randridgedinds(n,m,d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

isviable=zeros(1,d^n);
for i=1:m
    ind1=randi([1,d^n],1);
    ind2=randi([1,d^n],1);
    mypath=randminpath(n,d,ind1,ind2);
    for k=1:size(mypath,1)
        mytup=mypath(k,:)';
        myind=tup2ind(d*ones(n,1),mytup);
        isviable(myind)=1;
    end
    
end
viableinds=(1:d^n)';
viableinds=viableinds(isviable==1);

end