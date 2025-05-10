function plotgraph2(myplot,todraw,v,h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

inds=1:length(todraw);
inds=inds(todraw);

cmap=colormap(h,copper(256));
colorinds=ceil(256*v/max(v));
colorinds=max(1,colorinds);
for i=1:length(inds)
    myind=inds(i);
   highlight(myplot,myind,'NodeColor',cmap(colorinds(myind),:)) 
end

end