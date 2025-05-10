function fulladj = getSemifullAdj(ns,inds,mode)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    l=length(inds);
    if mode==0 
       nneighbs=sum(ns-1); 
    else
       nneighbs=2*length(ns); 
    end
    fulladj=zeros(l,nneighbs);
    reindex=containers.Map(inds,1:l);
    for i=1:l
       ind=inds(i);
       myneighbs=getNeighbs(ns,ind,mode);
       for j=1:length(myneighbs)
           neighb=myneighbs(j);
           if isKey(reindex,neighb)
              fulladj(i,j)=reindex(neighb);
           end
       end
    end
end

