unifrmsfreqs=zeros(3,1);

unifrmsfreqs(1)=mean(unifrmss(1,:)<unifrmss(2,:));
unifrmsfreqs(2)=mean(unifrmss(1,:)<unifrmss(3,:));
unifrmsfreqs(3)=mean(unifrmss(2,:)<unifrmss(3,:));
