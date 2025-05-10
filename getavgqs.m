function [avgqs,avgavgqs] = getavgqs(vs)
%
%vs is a collection of vectors of indices
%avgqs is the average, over all these vectors, of 1-cdf
%of the distribution of normalized eigencentralities
N=length(vs);
avgqs=zeros(N,101);
for j=1:50
    mytopeig=topeig(getAdj(2*ones(10,1),0,vs{j}));
    mytopeig=mytopeig/max(mytopeig);
    for i=1:101
        avgqs(j,i)=mean(mytopeig>=(i-1)/100);
    end
end
avgavgqs=mean(avgqs);
end

