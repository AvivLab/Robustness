function tv = totalVar(ps1,ps2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p=0;
q=0;
l=length(ps1);
for i=1:l
    if ps1(i)>ps2(i)
        p=p+ps1(i)-ps2(i);
    else
        q=q+ps2(i)-ps1(i);
    end
end

tv=max(p,q);
end