dmodes=cell(1,50);
dagg=[];
for i=1:50
    %calculate a disance matrix
    inds=lowpstruct.vs{i};
    A=getAdj(2*ones(10,1),0,inds);
    G=graph(A==1);
    D=distances(G);
   l=length(lowpstruct.vs{i});
   myds=zeros(l,14,2);
   for j=1:14
       unifps=lowpstruct.pss{i}(:,j);
       [~,unifmode]=max(unifps);
       for k=1:l
           myps=lowpstruct.isopss{i}(:,j,k);
           [~,mymode]=max(myps);
           v=[D(k,unifmode); D(k,mymode)];
           dagg=[dagg,v];
           myds(k,j,:)=v;
       end
   end
   dstart2modes{i}=myds;
end