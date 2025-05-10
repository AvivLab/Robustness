eigcentss=zeros(50,13);
for t=1:50
   myinds=vs{t};
   v0=topeig(getAdj(2*ones(10,1),0,myinds));
   myps=ps{t};
   for i=1:13
       myv=myps(:,i);
       myeigcent=v0'*myv;
       eigcentss(t,i)=myeigcent;
   end
end