function [v,robrs,robms] = mesadyn(n,m1,m2,r,mu,T)
%MESADYN 
%
%Inputs:
% n=length of sequence
% m1,m2 = lower and upper bounds on number of ones
% r,mu = recombination and mutation rates

    v=zeros(n+1,1);
    v((m1+1):(m2+1))=ones(m2-m1+1,1);
    v=v/weightedsum(v);
    robrs=zeros(1,T);
    robms=zeros(1,T);
    for t=1:T
       [w,robm]=mutastep(v,m1,m2);
       v=mu*w+(1-mu)*v;
       v=v/weightedsum(v);
       [w,robr]=mesastep(v,m1,m2);
       v=r*w+(1-r)*v;
       v=v/weightedsum(v);
       robrs(t)=robr;
       robms(t)=robm;
    end
    
end






