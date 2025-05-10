function diInds = flat2di(flinds,n)
%
%convert from "flat" (haploid) format to diploid format
%n is the dimension of each gamete
%
l=length(flinds);
diInds=zeros(l,2);
diInds(:,1)=mod(flinds-1,2^n)+1;
diInds(:,2)=floor((flinds-1)/(2^n))+1;
end