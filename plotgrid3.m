function plotgrid3(n,viableinds,v)
%PLOTGRID Summary of this function goes here
%   Detailed explanation goes here
    %if isempty(v)
    %   A=getAdj([n;n],1,viableinds);
    %   v=topeig(A);
    %end
    A=zeros(n);
    Z=zeros(n,n,3);
    m=length(viableinds);
    v=max(v,0);
    v=v./max(v);
    for i = 1:m
        pair= ind2tup([n,n],viableinds(i));
        A(pair(1),pair(2))=1;
        Z(pair(1),pair(2),:)=v(i,:);
    end
    
    %X=1:n;
    %Y=1:n;
    %figure();
    %surfl(X,Y,Z);
    figure();
    for i=1:n
        for j=1:n
            color='black';
            if A(i,j)==1
               color=[1-Z(i,j,1),1-Z(i,j,2),1-Z(i,j,3)]; 
            end
            fill([j,j+1,j+1,j],[i,i,i+1,i+1],color,'LineStyle','none')
            hold on
        end
    end
    %mymap=[ones(64,1),(63:(-1):0)'/63,(63:(-1):0)'/63];
    %colormap(mymap);
    %colorbar;
    axis([1,n+1,1,n+1]);
end