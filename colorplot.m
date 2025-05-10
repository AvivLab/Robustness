function colorplot(A,xs,ys,lowerbound,h)
%
%h: plot handle
[l,w]=size(A);
m=max(max(A));
eps=0.002;
%mymap=colormap(hot(256));
    %figure();
    for i=1:l
        i
        for j=1:w
            %a value of z = 0 is min, z=1 is max
            %myz=min((A(i,j)-lowerbound)*5,1);
            myz=(A(i,j)-lowerbound)/(m-lowerbound);
            if(myz>eps)
                color=[1,1-myz,1-myz];
                %color=cm(floor(254*A(i,j)/m)+1,:);
                fill([xs(j),xs(j+1),xs(j+1),xs(j)],[ys(i),ys(i),ys(i+1),ys(i+1)],color,'LineStyle','none')
                hold on
            end
        end
    end
    mymap=[ones(64,1),(63:(-1):0)'/63,(63:(-1):0)'/63];
    colormap(h,mymap);
    colorbar(h);
    caxis(h,[lowerbound,m]);
    axis(h,[xs(1),xs(w+1),ys(1),ys(l+1)]);
end

