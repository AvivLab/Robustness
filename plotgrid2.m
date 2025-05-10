function plotgrid2(n,pairs,v,h)
%
%mode: 0=surface, 1 = color
%h: plot handle
    A=zeros(n);
    Z=zeros(n);
    m=length(pairs);
    v=max(v,0);
    v=v/max(v);
    for i = 1:m
        A(pairs(i,1),pairs(i,2))=1;
        Z(pairs(i,1),pairs(i,2))=v(i);
    end
    
    for i=1:n
        for j=1:n
            color='black';
            if A(i,j)==1
               color=[1,1-Z(i,j),1-Z(i,j)]; 
            end
            fill([j,j+1,j+1,j],[i,i,i+1,i+1],color,'LineStyle','none')
            hold on
        end
    end
    mymap=[ones(64,1),(63:(-1):0)'/63,(63:(-1):0)'/63];
    colormap(h,mymap);
    colorbar(h);
    axis(h,[1,n+1,1,n+1]);
end