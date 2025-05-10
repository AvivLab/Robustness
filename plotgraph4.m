function ph = plotgraph4(A,v1,v2,h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

l=length(v1);
G=graph(A==1);
ph=plot(h,G,'NodeLabel',{});
cmap1=colormap(h,sky(256));
v1=ceil(256*v1/max(v1));
v1=max(1,v1);
cmap2=colormap(h,autumn(256));
v2=ceil(256*v2/max(v2));
v2=max(1,v2);
ph.MarkerSize=3;
for i=1:l
    if (v1(i)>v2(i) && v1(i) > 0.1)
        highlight(ph,i,'NodeColor',cmap1(colorinds1(i),:)) 
    end
    
    if (v2(i)>v1(i) && v2(i) > 0.1)
        highlight(ph,i,'NodeColor',cmap2(colorinds2(i),:)) 
    end
   
end
%colorbar(h);
end