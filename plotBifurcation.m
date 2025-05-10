function  plotBifurcation(inds,pss,d)
%
%scores: a matrix of scores (dim 2) across various parameters (dim 1)
%counts: a matrix of counts
%
A=getAdj(2*ones(d,1),0,inds);
eigs=topeig(A);
normeigs=eigs/max(eigs);
finalmodes=getfinalmodes({pss});
modecounts=getmodecounts(finalmodes);
counts=modecounts{1};
scores=normeigs(finalmodes{1});

[m,n]=size(scores);

for i=1:n
    plot(1:m,scores(:,i),'-');
    hold on
end

for i=1:n
    for j=1:m
        mymode=finalmodes{1}(j,i);
        plot(j,scores(j,i),'.r','MarkerSize',counts(j,mymode)/2);
        hold on
    end
end

figure(); plot(ones(1,n),normeigs,"*");

end

