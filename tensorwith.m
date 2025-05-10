function A = tensorwith(R,v)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n=length(R);
A=zeros(n);
for i=1:n
   A=A+v(i)*squeeze(R(i,:,:))'; 
end
end

