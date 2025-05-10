function peaks = getPeakEigs(inds,n)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
A=getAdj(2*ones(n,1),0,inds);
eigs=topeig(A);
l=length(A);
eps=0.0001;
peaks=[];
for i=1:l
   ispeak=true;
   for j=1:l
       if A(i,j)>0 && eigs(i)<eigs(j)-eps
          ispeak=false; 
       end
   end
   
   if ispeak
      peaks=[peaks,i]; 
   end
end
end

