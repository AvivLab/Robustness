function ps = recomb(x,y,r)
%   Creates a vector summarizing the probability distribution
%   that results from recombining x and y
d=length(x);
N=2^d;
ns=2*ones(1,d);
ps=zeros(N,1);
recombp=r/(2*(d-1));
indx=tup2ind(d,ns,x');
indy=tup2ind(d,ns,y');
if indx==indy
    ps(indx)=1;
else
    ps(indx)=(1-r)/2;
    ps(indy)=(1-r)/2;
    for i=1:(d-1)
        x1=x(1:i);
        x2=x((i+1):d);
        y1=y(1:i);
        y2=y((i+1):d);
        recomb1=[x1,y2];
        recomb2=[y1,x2];
        ind1=tup2ind(d,ns,recomb1');
        ind2=tup2ind(d,ns,recomb2');
        ps(ind1)=ps(ind1)+recombp;
        ps(ind2)=ps(ind2)+recombp;
    end
end
end