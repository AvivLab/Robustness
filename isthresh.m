function [is,thresh1,thresh2,thresh3] = isthresh(v1,v2)
%ISTHRESH Summary of this function goes here
%   Detailed explanation goes here
    epsilon=10^(-10);
    thresh1=max(v1(v2<epsilon));
    thresh2=min(v1(v1>thresh1));
    thresh3=max(v2(v1<=thresh1));
    is=(thresh3<epsilon);
    
    
    
end