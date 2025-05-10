%% 1 generate random unstructured diploid landscapes
rng(100);
n=8;
indsss=russiansweep(8,0.8,50,0,2,30,60);
indss=indsss{1};
diIndss = cell(1,50);
for i=1:50
    diIndss{i} = flat2di(indss{i},4);
end

save("diinds.mat", "diIndss");
%% 2. run dynamics, random assortment only
rng(100);
load("diinds.mat");
disortstruct = struct;
r = 0; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
pss = fulldynsweep(n,diIndss,r,dimus,2); %2 is for diploid
[~, normAvgEigs] = avgeigcent(diIndss,n,pss);
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
disortstruct.pss = pss;
disortstruct.avgeigs = normAvgEigs;
disortstruct.sls = sls;
disortstruct.ds = ds;
disortstruct.vs = vs;
disortstruct.normModeEigs = normModeEigs;
save("disortstruct.mat", "disortstruct");

%% 3.  Same as 2, but now with recombination 
rng(100);
load("diinds.mat");
disortstruct2 = struct;

r= 0.05; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
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
save("disortstruct2.mat","disortstruct2");

%% FIG 1. Generate diploid fig 1 % Similar to Figure 7 of the paper

load("disortstruct.mat");
figure();
h1=subplot(1,2,1);
plot(h1,dimus, disortstruct.avgeigs,LineWidth=1.5);
axis([0, 0.5, 0, 2]);
title(h1,'(A) Average eigencentrality');
xlabel(h1,"Mutation rate");
ylabel(h1,"Average eigencentrality");
set(gca,'fontweight','bold','fontsize',18)

h2=subplot(1,2,2);
plot(h2,dimus, disortstruct.sls,LineWidth=1.5);
axis([0, 0.5, 0, 1]);
title(h2,'(B) Localization');
xlabel(h2,"Mutation rate");
ylabel(h2,"Localization");
set(gca,'fontweight','bold','fontsize',18)

%% FIG 1S. supplemental diploid fig 1   % Actual Figure 7 of the paper
load("disortstruct2.mat");
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

%% dominant landscapes

rng(100);
%let's first try to make these big since the other one was so quick
n=12;
indsss=russiansweep(6,0.8,50,0,2,10,20);
indss=indsss{1};
domDiIndss = cell(1,1);
for i = 1:1
    domDiIndss{i} = uni2diand(indss{i});
end

%run dynamics, then compare to the haploid
r=0.1; dimus = [0.5,0.2,0.1,0.05,0.01,0.001];
pss = fulldynsweep(n,domDiIndss,r,dimus,2);

%haploid comparison

happss = fulldynsweep(n/2,indss, r, dimus, 1);

didomstruct.pss=pss;
didomstruct.indss=indss;
didomstruct.domindss= domDiIndss;
didomstruct.happss = happss;



hap2dipss = cell(1,1);

for i = 1:1
    l = length(indss{i});
    happs = happss{i};
    hap2dipss{i}=zeros(l^2,6);
    for j = 1:6
        for a = 1:l
            for b = 1:l
                c = a+l*(b-1);
                hap2dipss{i}(c,j) = happs(a,j)*happs(b,j);
            end
        end
    end
end

didomstruct.hap2dipss = hap2dipss;

save("didomstruct.mat","didomstruct")

%% 4. recessive

rng(100);
direcstruct=struct; 
n=10;
indsss=russiansweep(5,0.75,50,0,2,8,15);
indss=indsss{1};
recDiIndss = cell(1,50);
for i = 1:50
    recDiIndss{i} = uni2dior(indss{i},n/2);
end

direcstruct.indss=recDiIndss;
save("direcstruct.mat","direcstruct");

%% 5. run the dynamics, with no recombination
load("direcstruct.mat");
recDiIndss = direcstruct.indss;
r=0; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
pss = fulldynsweep(n,recDiIndss,r,dimus,2);

direcstruct.pss=pss;
save("direcstruct.mat","direcstruct");

%% 6. Calculate measures

load("direcstruct.mat");
vss= cell(1,50);
flindss = cell(1,50);
n=10;
indss = direcstruct.indss;
for i =1:50
i
inds = indss{i};
flinds = di2flat(inds,n/2);
A = getAdj(2*ones(1,n),0,flinds);
v = topeig(A);
vss{i}=v;
end
direcstruct.flindss = flindss;
direcstruct.vss=vss;


pss = direcstruct.pss;
sls = zeros(7,50);
ds = zeros(7,50);
avgeigs = zeros(7,50);
normModeEigs = zeros(7,50);
for i=1:50
    ps = pss{i};
    v = vss{i};
    for j = 1:7
        p = ps(:,j);
        sls(j,i) = simploc(p);
        ds(j,i) = totalVar(v,p);
        [~,m] = max(p);
        normModeEigs(j,i) = v(m)/max(v);
        avgeigs(j,i)=(v'*p)/(v'*v); %normalized average
    end

end
direcstruct.sls=sls;
direcstruct.avgeigs = avgeigs;
direcstruct.normModeEigs = normModeEigs;

%% 7. Similar to 5, but this time with recombination

load("direcstruct.mat");
recDiIndss = direcstruct.indss;
n=10;
r=0.1; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
pss = fulldynsweep(n,recDiIndss,r,dimus,2);

direcstruct2.pss=pss;
save("direcstruct2.mat","direcstruct2");

%% 8. Calculate measures (with recombination)

load("direcstruct.mat");
load("direcstruct2.mat");
indss = direcstruct.indss;
flindss = direcstruct.flindss;
vss = direcstruct.vss;
pss2 = direcstruct2.pss;
sls = zeros(7,50);
ds = zeros(7,50);
avgeigs = zeros(7,50);
normModeEigs = zeros(7,50);
for i=1:50
    ps = pss2{i};
    v = vss{i};
    for j = 1:7
        p = ps(:,j);
        sls(j,i) = simploc(p);
        ds(j,i) = totalVar(v,p);
        [~,m] = max(p);
        normModeEigs(j,i) = v(m)/max(v);
        avgeigs(j,i)=(v'*p)/(v'*v); %normalized average
    end

end
direcstruct2.sls=sls;
direcstruct2.avgeigs = avgeigs;
direcstruct2.normModeEigs = normModeEigs;
save("direcstruct2.mat","direcstruct2");

%% FIG 2 Not included in the paper

load("direcstruct.mat");
dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
figure();
subplot(1,2,1);
plot(dimus, direcstruct.avgeigs);
axis([0, 0.5, 0, 2]);
subplot(1,2,2);
plot(dimus, direcstruct.sls);
axis([0, 0.5, 0, 0.05]);

%% FIG 8

load("direcstruct.mat");
vss = direcstruct.vss;
v = vss{1};
pss=direcstruct.pss;
ps = pss{1};
p1=ps(:,1);
p2 = ps(:,6);
[w, i] = sort(v);
figure(); hold on;
plot(p1(i),".-b", 'LineWidth',1.5); 
plot(p2(i),".-r", 'LineWidth',1.5);
plot(w,"g", 'LineWidth',1.5);

eps=0.0001;
for j = 1: length(ps)
    if ps(i(j),7)>eps
        %xline(j);
        plot(j,p2(i(j)),"*r");
    end
end
legend("0.5 mutation","0.001 mutation","eigencentrality");
xlabel("Genotype");%,'FontWeight','bold','fontsize',18);
ylabel("Frequency");%,'FontWeight','bold','fontsize',18);
%fontsize(18,"points")
set(gca,'fontweight','bold','fontsize',20)

axes('Position',[.2 .5 .4 .4])
box on;
plot(100:350, p1(i(100:350)),".-b", 'LineWidth',1.5); hold on;
plot(100:350,p2(i(100:350)),".-r", 'LineWidth',1.5);
plot(100:350,w(100:350),"g", 'LineWidth',1.5);
set(gca,'fontweight','bold','fontsize',18)
for j = 100: 350
    if ps(i(j),7)>eps
        %xline(j);
        plot(j,p2(i(j)),"*r");
    end
end