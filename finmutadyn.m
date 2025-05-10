function pops = finmutadyn(n,inds,mu,N,pop,T)
%
%Mutation dynamics on finite populations
%inputs: n=number of loci,
%        inds=viables
%        mu=mutation
%        N = population size
%        pop = population vector
%        T = number of iterations
A=getAdj(2*ones(n,1),0,inds);
l=length(inds);
neighbs=zeros(l,n);
pops=zeros(N,T);
for i=1:l
    mycount=1;
    for j=1:l
        if A(i,j)
           neighbs(i,mycount)=j;
           mycount=mycount+1;
        end
    end
end
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
              myneighb=neighbs(myind,k);
              if myneighb>0
                 count=count+1;
                 newpop(count)=myneighb;
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
end

