function inds= mesarandinds(n,ms,p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ns=2*ones(n,1);
inds=[];
for i=1:(2^n)
    if rand()<p
        mytup=ind2tup(ns,i);
        m=sum(mytup-1);
        if sum(ms==m)==1
            inds=[inds;i];
        end    
    end
end

end