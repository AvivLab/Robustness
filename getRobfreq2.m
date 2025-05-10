rmsfreqs=zeros(3,50);
for i=1:50
    myrms=rmss{i};
    rmsfreqs(1,i)=mean(myrms(1,:)<myrms(2,:));
    rmsfreqs(2,i)=mean(myrms(1,:)<myrms(3,:));
    rmsfreqs(3,i)=mean(myrms(2,:)<myrms(3,:));
end