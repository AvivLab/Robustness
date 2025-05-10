function [scores1,scores2, avgscore] = recombscores(R,ps1,ps2)
%
% Score 1: for each genotype, how likely is it to be a "recombinant"

l=length(R);
scores1=zeros(l,1);
scores2=zeros(l,1);
for i=1:l
    scores1(i)=ps1'*R(:,:,i)*ps1;
end
for i=1:l
    scores2(i)=ps1'*squeeze(R(i,:,:))*ps1;
end
avgscore=scores1'*ps2;

end