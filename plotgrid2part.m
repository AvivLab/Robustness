function plotgrid2part(pairs,v,h)
%
%mode: 0=surface, 1 = color
%h: plot handle
    m=length(pairs);
    v=max(v,0);
    v=v/max(v);
    for k = 1:m
        i=pairs(k,1); j=pairs(k,2);
        myv=v(k);
        color=[1,1-myv,1-myv];
        %plot(h, j+(1/2), i+(1/2), '.','Color',color,'MarkerSize',20);
        fill(h,[j,j+1,j+1,j],[i,i,i+1,i+1],color,'LineStyle','none')
        hold on;
    end
end