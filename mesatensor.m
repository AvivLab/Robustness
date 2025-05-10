function R = mesatensor(n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%condprob(l,j,k) will encode the probability
%of picking a genotype with 
R=zeros(n+1,n+1,n+1);
for l=0:n
    for j1=0:l
        for k1=0:(n-l)
            for j2=0:l
                for k2=0:(n-l)
                    %this represents the situation that we have recomb at position l
                    %parent 1 has j1 1's before l, k1 after
                    %similarly parent 2
                    %Say inherit the length-l part from parent 1
                    P1=nchoosek(n-l,k1);
                    P2=nchoosek(l,j2);
                    val1=j1+k1;
                    val2=j2+k2;
                    valoff=j1+k2;
                    contr=nchoosek(valoff,j1)*nchoosek(n-valoff,l-j1)*P1*P2/(2^n);
                    R(val1+1,val2+1,valoff+1)=R(val1+1,val2+1,valoff+1)+contr;
                end
            end
        end
    end
end
end