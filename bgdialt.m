%% 1 generate random unstructured diploid landscapes
rng(100);
n=10;
N=50;
indsss=russiansweep(n/2,0.8,N,0,3,30,60);
ternIndss=indsss{1}; %ternary
diIndss = cell(1,N); %diploid
indss = cell(1,N);   %flat
for i=1:N
    diIndss{i} = ternary2di(ternIndss{i},n/2);
    indss{i} = di2flat(diIndss{i},n/2);
end


save("dialtinds.mat", "diIndss");
%% 2. run dynamics, random assortment only
rng(100);
load("dialtinds.mat");
disortstruct = struct;
disortstruct.indss = diIndss;
r = 0; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
pss = fulldynsweep(n,diIndss,r,dimus,2); %2 is for diploid
disortstruct.pss = pss;
save("disortstructalt.mat", "disortstruct");

%% 2.5. Run measures
load("dialtinds.mat");
load("disortstructalt.mat");
[~, normAvgEigs] = avgeigcent(diIndss,n,pss);
l=length(dimus);
sls = zeros(l,N);
ds = zeros(l,N);
normModeEigs = zeros(l,N);
vs = cell(1,N);
for i=1:N
    inds = indss{i};
    ps = pss{i};
    v = topeig(getAdj(2*ones(n,1),0,inds));
    vs{i} = v;
    for j = 1:l
        p = ps(:,j);
        sls(j,i) = simploc(p);
        ds(j,i) = totalVar(v,p);
        [~,m] = max(p);
        normModeEigs(j,i) = v(m)/max(v);       
    end

end
disortstruct.avgeigs = normAvgEigs;
disortstruct.sls = sls;
disortstruct.ds = ds;
disortstruct.vs = vs;
disortstruct.normModeEigs = normModeEigs;
save("disortstructalt.mat", "disortstruct");

%% 3.  Same as 2, but now with recombination 
rng(100);
load("dialtinds.mat");
disortstruct2 = struct;

r= 0.1; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
pss = fulldynsweep(n,diIndss,r,dimus,2); %2 is for diploid
[avgeigs, normAvgEigs] = avgeigcent(diIndss,n,pss);
l=length(dimus);
sls = zeros(l,50);
ds = zeros(l,50);
normModeEigs = zeros(l,50);
vs = cell(1,50);
for i=1:50
    inds = indss{i};
    ps = pss{i};
    v = topeig(getAdj(2*ones(n,1),0,inds));
    vs{i} = v;
    for j = 1:l
        p = ps(:,j);
        sls(j,i) = simploc(p);
        ds(j,i) = totalVar(v,p);
        [~,m] = max(p);
        normModeEigs(j,i) = v(m)/max(v);       
    end

end
disortstruct2.pss = pss;
disortstruct2.avgeigs = normAvgEigs;
disortstruct2.sls = sls;
disortstruct2.ds = ds;
disortstruct2.vs = vs;
disortstruct2.normModeEigs = normModeEigs;
save("disortstruct2alt.mat","disortstruct2");

%% FIG 1. Generate diploid fig 1 % Figure 7 of the paper

load("disortstructalt.mat");
figure();
h1=subplot(1,2,1);
plot(h1,dimus, disortstruct.avgeigs,LineWidth=1.5);
axis([0, 0.5, 0, 2]);
title(h1,'(A) Average eigencentrality');
xlabel(h1,"Mutation rate",'FontWeight');
ylabel(h1,"Average eigencentrality");
set(gca,'fontweight','bold','fontsize',18)

h2=subplot(1,2,2);
plot(h2,dimus, disortstruct.sls,LineWidth=1.5);
axis([0, 0.5, 0, 1]);
title(h2,'(B) Localization');
xlabel(h2,"Mutation rate");
ylabel(h2,"Localization");
set(gca,'fontweight','bold','fontsize',18)

%% FIG 1S. supplemental diploid fig 1   % Figure 7 of the paper
load("disortstruct2alt.mat");
figure();
h1=subplot(1,2,1);
plot(h1,dimus, disortstruct2.avgeigs,LineWidth=1.5);
axis([0, 0.5, 0, 2]);
title(h1,'(A) Average eigencentrality');
xlabel(h1,"Mutation rate");
ylabel(h1,"Average eigencentrality");
set(gca,'fontweight','bold','fontsize',18)

h2=subplot(1,2,2);
plot(h2,dimus, disortstruct2.sls,LineWidth=1.5);
axis([0, 0.5, 0, 1]);
title(h2,'(B) Localization');
xlabel(h2,"Mutation rate");
ylabel(h2,"Localization");
set(gca,'fontweight','bold','fontsize',18)
