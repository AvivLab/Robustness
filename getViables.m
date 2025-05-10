function inds = getViables(mp)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    myKeys=keys(mp);
    myVals=values(mp);
    inds=[];
    for i=1:length(myKeys)
       if myVals{i}==1
          inds=[inds ,myKeys{i}]; 
       end
    end
end

