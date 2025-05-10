%script for generating all the data to be loaded into masterscript

%% Geometric Russian Roulette

rng(100);

%russianstruct
indsss=russiansweep(10:50,0.1:0.01:0.3,50,1,2,0);
sls=zeros(41,21,50);
nsls=zeros(41,21,50);
eds=zeros(41,21,50);
for i=1:41
    for j=1:21
        %i
        %j
        for k=1:50
            inds=indsss{i,j}{k};
            n=i+9;
            p=0.69+(j/10);
            A=getAdj([n,n],1,inds);
            v=topeig(A);
            [sls(i,j,k),nsls(i,j,k)]=simploc(v);
            eds(i,j,k)=expdist([n,n],inds, v);
        end
    end
end

russianstruct=struct;
russianstruct.indsss=indsss;
russianstruct.sls=sls;
russianstruct.nsls=nsls;
russianstruct.eds=eds;

save("russianstruct.mat", "russianstruct");

%% Genetic Russian Roulette
rng(100);

%russianstruct2
[indsss2,vss2]=russiansweep(6:12,0.1:0.05:0.8,50,0,2,0);
russianstruct2=struct;
russianstruct2.indsss=indsss2;
sls2=zeros(7,15,50);
nsls2=zeros(7,15,50);
for i=1:7
    for j=1:15
        %i
        %j
        for k=1:50
            inds=indsss2{i,j}{k};
            v=vss2{i,j}{k};
            [sls2(i,j,k),nsls2(i,j,k)]=simploc(v);
        end
    end
end
russianstruct2.sls=sls2;
russianstruct2.nsls=nsls2;

indsss3 = indsss2; % I think?
save("russianstruct2.mat", "russianstruct2","indsss3");

%% Mutation-recombination dynamics, low p

%note russiansweep only calculates the landscapes and their
%eigencentralities. Now we need to also run dynamics with recombination,
%with low and high p. 

%low p = 0.2 (0.8) with n = 10, high p = 0.8 (0.2) with n = 8. I believe.

%lowpstruct and hipstruct

load("mus.mat");
load("russianstruct2.mat");
indsss2 = russianstruct2.indsss;
rng(100);

lowpstruct = struct;
n=10;
indss = indsss2{5,15};
r=0.1;
mode = 1; %recombination mode (1 = "point recombination")
%run dynamics
pss = fulldynsweep(n,indss,r,mus,mode);
%calculate measures
avgeigs = avgeigcent(indss,n,pss)'; %transpose for the right shape
sls = zeros(14,50);
ds = zeros(14,50);
normModeEigs = zeros(14,50);
vs = cell(1,50);
for i=1:50
    inds = indss{i};
    ps = pss{i};
    v = topeig(getAdj(2*ones(n,1),0,inds));
    vs{i} = v;
    for j = 1:14
        p = ps(:,j);
        sls(j,i) = simploc(p);
        ds(j,i) = totalVar(v,p);
        [~,m] = max(p);
        normModeEigs(j,i) = v(m)/max(v);       
    end

end
lowpstruct.pss = pss;
lowpstruct.avgeigs = avgeigs;
lowpstruct.sls = sls;
lowpstruct.ds = ds;
lowpstruct.vs = vs;
lowpstruct.normModeEigs = normModeEigs;

save("lowpstruct.mat", "lowpstruct");

%% isogenic sweep, low p

load("mus.mat");
load("russianstruct2.mat");
load("lowpstruct.mat");
indsss2 = russianstruct2.indsss;
rng(100);

n=10;
indss = indsss2{5,15};
r=0.1;

isopss = fulldynisosweep(n,indss,r,mus);
isosls = cell(1,50);
isods = cell(1,50);
isonormModeEigs = cell(1,50);
for i = 1:50
    pss= isopss{i}; %3d matrix, ordered init,ind,mut
    l=length(vs{i});
    mysls = zeros(14,l);
    myds = zeros(14,l);
    mynormModeEigs = zeros(14,l);
    v=vs{i};
    for k = 1:l
        for j = 1:14
            p=pss(k,:,j);
            mysls(j,k)=simploc(p);
            myds(j,k) = totalVar(v,p);
            [~,m] = max(p);
            mynormModeEigs(j,k) = v(m)/max(v); 
        end
    end
    isosls{i}=mysls;
    isods{i}=myds;
    isonormModeEigs{i}=mynormModeEigs;
end

lowpstruct.isopss=isopss;
lowpstruct.isosls=isosls;
lowpstruct.isods = isods;
lowpstruct.isonormModeEigs = isonormModeEigs;
save("lowpstruct.mat", "lowpstruct");

%% Mutation-recombination, high p

load("mus.mat");
load("russianstruct2.mat");
indsss2 = russianstruct2.indsss;
rng(100);

hipstruct = struct;
n=8;
indss = indsss2{3,3};
r=0.1;
mode = 1; %recombination mode (1 = "point recombination")

%run dynamics
pss = fulldynsweep(n,indss,r,mus,mode);
%calculate measures
avgeigs = avgeigcent(indss,n,pss)'; %transpose for the right shape
sls = zeros(14,50);
ds = zeros(14,50);
normModeEigs = zeros(14,50);
vs = cell(1,50);
for i=1:50
    inds = indss{i};
    ps = pss{i};
    v = topeig(getAdj(2*ones(n,1),0,inds));
    vs{i} = v;
    for j = 1:14
        p = ps(:,j);
        sls(j,i) = simploc(p);
        ds(j,i) = totalVar(v,p);
        [~,m] = max(p);
        normModeEigs(j,i) = v(m)/max(v);       
    end

end
hipstruct.pss = pss;
hipstruct.avgeigs = avgeigs;
hipstruct.sls = sls;
hipstruct.ds = ds;
hipstruct.vs = vs;
hipstruct.normModeEigs = normModeEigs;
save("hipstruct.mat", "hipstruct");

%% isogenic sweep high p

load("mus.mat");
load("russianstruct2.mat");
load("hipstruct.mat");
indsss2 = russianstruct2.indsss;
rng(100);

hipstruct = struct;
n=8;
p=0.2;
indss = indsss2{3,3};
r=0.1;


isopss = fulldynisosweep(n,indss,r,mus);
isosls = cell(1,50);
isods = cell(1,50);
isonormModeEigs = cell(1,50);
for i = 1:50
    pss= isopss{i}; %3d matrix, ordered init,ind,mut
    l=length(vs{i});
    mysls = zeros(14,l);
    myds = zeros(14,l);
    mynormModeEigs = zeros(14,l);
    v=vs{i};
    for k = 1:l
        for j = 1:14
            p=pss(k,:,j);
            mysls(j,k)=simploc(p);
            myds(j,k) = totalVar(v,p);
            [~,m] = max(p);
            mynormModeEigs(j,k) = v(m)/max(v); 
        end
    end
    isosls{i}=mysls;
    isods{i}=myds;
    isonormModeEigs{i}=mynormModeEigs;
end

hipstruct.isopss=isopss;
hiwpstruct.isosls=isosls;
hipstruct.isods = isods;
hipstruct.isonormModeEigs = isonormModeEigs;
save("hipstruct.mat", "hipstruct");

%%

save("background.mat","russianstruct","russianstruct2","indsss3","lowpstruct","hipstruct");