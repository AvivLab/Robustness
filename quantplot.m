function  quantplot(h,x,mus)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
quants=quantile(x,[0.05,0.1,0.25,0.5,0.75,0.95],2);
y1=quants(:,3)';
y2=quants(:,5)';
p=patch(h,[mus fliplr(mus)], [y1 fliplr(y2)], 'cyan');
p.FaceAlpha=0.1;
p.EdgeAlpha=0.1;
hold on;
p2=plot(h,mus,quants(:,4),'r',LineWidth=1.5);
p3=plot(h,mus,quants(:,6),'--b',LineWidth=1.5);
plot(h,mus, quants(:,1),'--b',LineWidth=1.5)
lgd=legend(h,[p p2 p3], {'25-75 percentiles','Median','5th and 95th percentiles'},'FontWeight','bold','fontsize',18);
%lgd.FontSize=14;
end

