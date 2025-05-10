function viablepairs=contigrandgrid(n,p)
%CONTIGRANDGRID Summary of this function goes here
%   Detailed explanation goes here
    queue=[n/2,n/2];
    N=n^2;
    visited=zeros(N,1);
    visited(tup2ind(2,[n,n],[n/2;n/2]))=1;
    viablepairs=[1,1];
    while ~isempty(queue)
        [queue,curpair]=dequeue(queue);
        myind=tup2ind(2,[n,n],curpair');
        myneighbs=getNeighbs([n,n],myind,1);
        for neighb = myneighbs
           if rand()<p
               if ~visited(neighb)
                   newpair=ind2tup(2,[n,n],neighb)';
                   queue=enqueue(queue,newpair);
                   visited(neighb)=1;
                   viablepairs=[viablepairs;newpair];
               end
           end
        end
        
    end
plotgrid(n,viablepairs,ones(1,length(viablepairs)));
end

function queue = enqueue(queue,x)
    queue=[queue;x];
end

function [queue,x] = dequeue(queue)
    %assumes queue nonempty
    x=queue(1,:);
    l=size(queue,1);
    queue=queue(2:l,:);
end