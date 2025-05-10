function plotgraph3(A,v,h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

l=length(v);
G=graph(A==1);
ph=plot(h,G,'NodeLabel',{});
v=max(v,0);
v=v./max(v);
%cmap=colormap(h,copper(256));
%colorinds=ceil(256*v/max(v));
%colorinds=max(1,colorinds);
for i=1:l
   highlight(ph,i,'NodeColor',[v(i,1),v(i,2),v(i,3)]); 
end
%colorbar(h);
end