function [x,y,z,T] = getdomridged(n,m)
%
%Inputs: n=number of loci, m=number of paths
%Outputs: x= indices for binary representation of landscape
%           (1 representing 00, 2 representing {01,10,11})
%         y= indices for ternary representation of landscape
%            (1 representing 00, 2 representing {01,10}, 3 representing 11)
%         z= indices for di-binary representation of landscape
%         T= a change-of-basis matrix between a di-binary and ternary representation    
x=randridgedinds(n,m,2); %base 2, 
y=bi2domtern(x,n); %converts to base 3
[z,T]=ternary2di(y',n);
end

