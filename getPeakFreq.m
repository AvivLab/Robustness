function peakfreqs = getPeakFreq(vs,pss,d)
%
%vs: cell of n vectors of indices
%pss: cell of distributions over these indices, across m different
%parameter settings
%d: the dimension (number of loci)
%
%peakfreqs: nxm matrix of the frequency of distributions in which the mode
%is also a local peak of eigen-centrality.

%note, pss is 3 dim. The dimensions represent ind,mut,init
%we use m for the number of mutations

n=length(vs);
m=size(pss{1},2);
peakfreqs=zeros(n,m);
eps=0.0001;
for i=1:n
    myinds=vs{i};
    l=length(myinds);
    r=size(pss{i},3);
    myA=getAdj(2*ones(d,1),0,myinds);
    myeig=topeig(myA);
    for j=1:m
        mycount=0;
        for k=1:r
           myp=pss{i}(:,j,k);
           [~,mymode]=max(myp);
           ispeak=true;
           for x=1:l
               if myA(mymode,x)==1 && myeig(mymode)<myeig(x)-eps
                  ispeak=false; 
               end
           end
           if ispeak
              mycount=mycount+1; 
           end
        end
        peakfreqs(i,j)=mycount/r;
    end
end
end

