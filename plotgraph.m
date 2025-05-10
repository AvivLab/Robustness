function ph = plotgraph(A,v,h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

l=length(v);
G=graph(A==1);
ph=plot(h,G,'NodeLabel',{});
Y=copper(256);
%Y=Y(256:-1:1,:);
cmap=colormap(h,Y);
%cmap=colormap(h,sky(256));
colorinds=ceil(256*v/max(v));
colorinds=max(1,colorinds);
ph.MarkerSize=7;
for i=1:l
   highlight(ph,i,'NodeColor',cmap(colorinds(i),:)) 
end
colorbar(h);
end