function ps = partialMutRob(ns, viabilityMap)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mykeys = keys(viabilityMap);
ps=zeros(length(mykeys),1);
for i=1:length(mykeys)
    mykey=mykeys(i);
    ind=mykey{1};
    count=0;
    viableCount=0;
    neighbs=getNeighbs(ns,ind,0);
    for neighb=neighbs
        if isKey(viabilityMap,neighb)
           count=count+1;
           if viabilityMap(neighb)
              viableCount=viableCount+1; 
           end
        end
    end
    ps(i)=viableCount/count;
end

end

