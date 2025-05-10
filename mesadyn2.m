function [v,robrs,robms] = mesadyn2(n,ms,r,mu,T)
%MESADYN Summary of this function goes here
%   Detailed explanation goes here
    v=zeros(n+1,1);
    l=length(ms);
    v(ms+1)=ones(l,1);
    v=v/weightedsum(v);
    robrs=zeros(1,T);
    robms=zeros(1,T);
    for t=1:T
       [w,robm]=mutastep2(v,ms);
       v=mu*w+(1-mu)*v;
       v=v/weightedsum(v);
       [w,robr]=mesastep2(v,ms);
       v=r*w+(1-r)*v;
       v=v/weightedsum(v);
       robrs(t)=robr;
       robms(t)=robm;
    end
    
end






