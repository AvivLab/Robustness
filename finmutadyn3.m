function [pss,reindex] = finmutadyn3(n,inds,mu,N,ps,T)
%
%Mutation dynamics on finite populations
%inputs: n=number of loci,
%        viablefn = function handle for testing viability of an index
%        mu=mutation
%        N = population sizee
%        pop = initial population vector
%        T = number of iterations
%        viabilityMap: a (partial) map of indices to viability
%outputs: pops= populations across time
%         viability: updated viability map

%%format of viability : a partial sparse matrix


%initialize... for now suppose that pop is all 1s
l=length(inds);
reindex=containers.Map(inds,1:l);
pss=zeros(l,T);
fulladj=zeros(l,n);
for i=1:l
   mytup= ind2tup(2*ones(n,1),inds(i));
   for j=1:n
      myneighb=mytup;
      myneighb(j)=3-mytup(j);
      neighbind=tup2ind(2*ones(n,1),myneighb);
      if isKey(reindex,neighbind)
          fulladj(i,j)=reindex(neighbind);
      else
          fulladj(i,j)=-1;
      end
   end
end

for t=1:T
   xs=mnrnd(N,ps);
   ys=xs;
   tomut=1:l;
   tomut=tomut(xs>0);
   for i=tomut
      nmuts=binornd(xs(i),mu);
      ys(i)=ys(i)-nmuts;
      for j=1:nmuts
          k=unidrnd(n,1);
          neighbind=fulladj(i,k);
          if neighbind>0
             ys(neighbind)=ys(neighbind)+1; 
          end
      end
   end
   ps=ys/sum(ys);
   pss(:,t)=ps;
end

end



