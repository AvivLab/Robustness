function S = getsubsets(k)
    if k==1
        S=[0;1];
    else
       Sprev=getsubsets(k-1);
       S=[zeros(2^(k-1),1),Sprev;ones(2^(k-1),1),Sprev];
    end
end