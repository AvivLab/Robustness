x=[];
for i = 1: 50
    p = lowpstruct.pss{i}(:,14);
    x=[x,sum(p>eps)];
end