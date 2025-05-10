%% generate diploid landscapes

%we can actually reuse the same landscapes we looked at in the haploid
%setting, reconceptualized as diploid.

load("lowpstruct.mat");
indss = lowpstruct.indss;

%note for diploid, strict connectedness is no longer as paramount. Though
%this is also true for haploid. What matters is the existence of a path
%under mutation *or* recombination. 
end