function [pops,viabilityMap,reindexMap,tuplst,A] = finmutadyn2(n,viablefn,mu,N,pop,T,viabilityMap0)
%
%Mutation dynamics on finite populations
%inputs: n=number of loci,
%        viablefn = function handle for testing viability of an index
%        mu=mutation
%        N = population size
%        pop = initial population vector
%        T = number of iterations
%        viabilityMap: a (partial) map of indices to viability
%outputs: pops= populations across time
%         viabilityMap: updated viability map

if isempty(viabilityMap0)
   viabilityMap=containers.Map('KeyType','char','ValueType','uint8'); 
else
    viabilityMap=containers.Map(keys(viabilityMap0),values(viabilityMap0));
end

tuplst=ones(1,n);
reindexMap=containers.Map('KeyType','char','ValueType','any');
reindexMap(num2str(ones(1,100)))=1;
edges=[];

%initialize... assume for now it starts at 1
indcount=1;
uniquecount=1;

pops=zeros(N,T);
for t=1:T
   count=0;
   newpop=zeros(N,1);
   while count<N
       M=N-count;
       draw=unidrnd(N,[M,1]);
       for i=1:M
           myind=pop(draw(i));
           if rand()<mu
              k=unidrnd(n,1);
              mytup=tuplst(myind,:);
              uind=reindexMap(num2str(mytup));
              mytup(k)=3-mytup(k);
              if isviable(mytup)
                  nuind=reindexMap(num2str((mytup)));
                  count=count+1;
                  indcount=indcount+1;
                  tuplst=[tuplst;mytup];
                  edges=[edges; uind,nuind; nuind, uind];
                  newpop(count)=indcount;
              end
           else
               count=count+1;
               newpop(count)=myind;
           end
       end
   end
   pop=newpop;
   pops(:,t)=pop;
end
%reindexMap=containers.Map(keys(viabilityMap),1:length(viabilityMap));
A=sparse(edges(:,1),edges(:,2),ones(length(edges),1));

    function boo = isviable(tup)
        tupstr=num2str(tup);
        if isKey(viabilityMap,tupstr)
            'is key';
            boo=viabilityMap(tupstr);
            tup;
        elseif isa(viablefn,'double')
            p=viablefn;
            x=rand();
            boo=x<p;
            tup;
            viabilityMap(tupstr)=boo;
            if boo
               uniquecount=uniquecount+1;
               reindexMap(tupstr)=uniquecount;
            end
        else
           boo= viablefn(tup);
           viabilityMap(tup)=boo;
        end
    end

end



