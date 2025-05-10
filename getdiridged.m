function [x,y,z,T] = getdiridged(n,m,mode)
%
%Inputs: n=number of loci, m=number of paths, mode=dominant (1) or not (0)
%Outputs: x= if applicable, indices for binary representation of landscape
%           (1 representing 00, 2 representing {01,10,11})
%         y= indices for ternary representation of landscape
%            (1 representing 00, 2 representing {01,10}, 3 representing 11)
%         z= indices for di-binary representation of landscape
%         T= a change-of-basis matrix between a di-binary and ternary representation 
if mode==0
   x=[];
   y=randridgedinds(n,m,3); %base 3
else
    x=randridgedinds(n,m,2); %base 2 
    y=bi2domtern(x,n); %converts to base 3
end
[z,T]=ternary2di(y',n);
end

