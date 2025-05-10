%script for generating all the data to be loaded into masterscript


%% 1. Geometric Russian Roulette -- generate landscapes

rng(100);

%russianstruct
russianstruct = struct;
[indsss,vss]=russiansweep(10:50,0.1:0.01:0.3,50,1,2,0);
russianstruct.indsss = indsss;
russianstruct.vss = vss;
save("russianstruct.mat", "russianstruct");

%% 2. Geometric Russian Roulette -- calculate measures
load("russianstruct.mat");
indsss = russianstruct.indsss;
sls=zeros(41,21,50);
nsls=zeros(41,21,50);
eds=zeros(41,21,50);
rob0s = zeros(41,21,50);
rob1s = zeros(41,21,50);
for i=1:41
    n=i+9;
    ns = [n,n];
    for j=1:21
        %i
        %j
        for k=1:50
            inds=indsss{i,j}{k};
            p=0.69+(j/10);
            A=getAdj([n,n],1,inds);
            v=topeig(A);
            [sls(i,j,k),nsls(i,j,k)]=simploc(v);
            eds(i,j,k)=expdist([n,n],inds, v);
            l = length(inds); %length
            d = 4; %max degree
            rob0s(i,j,k) = ones(1,l)/d*A*ones(l,1)/l;
            rob1s(i,j,k) = ones(1,l)/d*A*v;
        end
    end
end

russianstruct.sls=sls;
russianstruct.nsls=nsls;
russianstruct.eds=eds;
russianstruct.rob0s = rob0s;
russianstruct.rob1s = rob1s;

save("russianstruct.mat", "russianstruct");

%% 3. Genetic Russian Roulette -- generate landscapes
rng(100);

%russianstruct2
[indsss,vss]=russiansweep(6:12,0.1:0.05:0.8,50,0,2,0);
russianstruct2=struct;
russianstruct2.indsss=indsss;
russianstruct2.indsss = indsss;
russianstruct2.vss=vss;
save("russianstruct2.mat", "russianstruct2");

%% 4. Genetic Russian Roulette -- calculate measures
load("russianstruct2.mat");
indsss = russianstruct2.indsss;
vss = russianstruct2.vss;
sls2=zeros(7,15,50);
nsls2=zeros(7,15,50);
rob0s = zeros(7,15,50);
rob1s = zeros(7,15,50);
for i=1:7
    n=i+5;
    ns=2*ones(1,n);
    for j=1:15
        %i
        %j
        for k=1:50
            inds=indsss{i,j}{k};
            A=getAdj(ns,0,inds);
            v=vss{i,j}{k};
            [sls2(i,j,k),nsls2(i,j,k)]=simploc(v);
            l = length(inds); %length
            d = n; %max degree
            rob0s(i,j,k) = ones(1,l)/d*A*ones(l,1)/l;
            rob1s(i,j,k) = ones(1,l)/d*A*v;
        end
    end
end
russianstruct2.sls=sls2;
russianstruct2.nsls=nsls2;
russianstruct2.rob0s = rob0s;
russianstruct2.rob1s = rob1s;

indsss3 = indsss; % I think?
save("russianstruct2.mat", "russianstruct2","indsss3");

%% 5. Mutation-recombination dynamics, low p

%note russiansweep only calculates the landscapes and their
%eigencentralities. Now we need to also run dynamics with recombination,
%with low and high p. 

%low p = 0.2 (0.8) with n = 10, high p = 0.8 (0.2) with n = 8. I believe.

%lowpstruct and hipstruct

load("mus.mat");
load("russianstruct2.mat");
indsss = russianstruct2.indsss;
rng(100);

lowpstruct = struct;
n=10;
indss = indsss{5,15};
r=0.5;
mode = 1; %recombination mode (1 = "point recombination")
%run dynamics
pss = fulldynsweep(n,indss,r,mus,mode);
lowpstruct.pss = pss;
lowpstruct.indss = indss;
save("lowpstruct.mat", "lowpstruct");

%% 6. Mutation-recombination dynamics, low p-- calculate measures
%load("lowpstruct.mat");
n=10;
pss = lowpstruct.pss;
indss = lowpstruct.indss;
%avgeigs = avgeigcent(indss,n,pss)'; %transpose for the right shape
sls = zeros(14,50);
ds = zeros(14,50);
avgeigs = zeros(14,50);
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
        avgeigs(j,i)=(v'*p)/(v'*v); %normalized average
    end

end
lowpstruct.pss = pss;
lowpstruct.avgeigs = avgeigs;
lowpstruct.sls = sls;
lowpstruct.ds = ds;
lowpstruct.vs = vs;
lowpstruct.normModeEigs = normModeEigs;

save("lowpstruct.mat", "lowpstruct");

%% 7. isogenic sweep, low p

load("mus.mat");
load("lowpstruct.mat");
rng(100);

n=10;
indss = lowpstruct.indss;
r=0.1;

isopss = fulldynisosweep(n,indss,r,mus);
for i=1:50
isopss{i} = permute(isopss{i},[2,3,1]);
end
lowpstruct.isopss = isopss;
save("lowpstruct.mat", "lowpstruct");

%% 8. isogenic sweep, low p -- calculate measures
%load("lowpstruct.mat");
isopss = lowpstruct.isopss;
vs = lowpstruct.vs;
isosls = cell(1,50);
isods = cell(1,50);
isonormModeEigs = cell(1,50);
isoavgeigs = cell(1,50);
for i = 1:50
    pss= isopss{i}; %3d matrix, ordered ind,mut,init
    l=length(vs{i});
    mysls = zeros(14,l);
    myds = zeros(14,l);
    mynormModeEigs = zeros(14,l);
    myavgeigs=zeros(14,l);
    v=vs{i};
    for k = 1:l
        for j = 1:14
            p=pss(:,j,k);
            mysls(j,k)=simploc(p);
            myds(j,k) = totalVar(v,p);
            [~,m] = max(p);
            mynormModeEigs(j,k) = v(m)/max(v);
            myavgeigs(j,k)=(v'*p)/(v'*v);
        end
    end
    isosls{i} = mysls;
    isods{i} = myds;
    isonormModeEigs{i} = mynormModeEigs;
    isoavgeigs{i} = myavgeigs;
end

lowpstruct.isopss=isopss;
lowpstruct.isosls=isosls;
lowpstruct.isods = isods;
lowpstruct.isonormModeEigs = isonormModeEigs;
lowpstruct.isoavgeigs=isoavgeigs;
save("lowpstruct.mat", "lowpstruct");

%% 9. Mutation-recombination, high p -- run dynamics

load("mus.mat");
load("russianstruct2.mat");
%load("hipstruct.mat");
indsss = russianstruct2.indsss;
rng(100);

hipstruct = struct;
n=8;
indss = indsss{3,3};
r=0.5;
mode = 1; %recombination mode (1 = "point recombination")

%run dynamics
pss = fulldynsweep(n,indss,r,mus,mode);
hipstruct.pss = pss;
hipstruct.indss = indss;
save("hipstruct.mat","hipstruct");

%% 10. high p -- calculate measures
%load("hipstruct.mat", "hipstruct")
pss= hipstruct.pss;
indss = hipstruct.indss;
n=8; %set n to that set in section 9 above
%avgeigs = avgeigcent(indss,n,pss)'; %transpose for the right shape
avgeigs=zeros(14,50);
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
        avgeigs(j,i)=(v'*p)/(v'*v);
    end

end
hipstruct.pss = pss;
hipstruct.avgeigs = avgeigs;
hipstruct.sls = sls;
hipstruct.ds = ds;
hipstruct.vs = vs;
hipstruct.normModeEigs = normModeEigs;
save("hipstruct.mat", "hipstruct");

%% 11. isogenic sweep high p

load("mus.mat");
load("hipstruct.mat");
rng(100);

n=8;
p=0.2;
indss = hipstruct.indss;
r=0.1;

isopss = fulldynisosweep(n,indss,r,mus);
%permute the order...
for i=1:50
isopss{i} = permute(isopss{i},[2,3,1]);
end
hipstruct.isopss = isopss;
save("hipstruct.mat", "hipstruct");

%% 12. isogenic high p -- calculate measures
%load("hipstruct.mat","hipstruct");
isopss= hipstruct.isopss;
vs = hipstruct.vs;
isosls = cell(1,50);
isods = cell(1,50);
isonormModeEigs = cell(1,50);
isoavgeigs = cell(1,50);
for i = 1:50
    ps= isopss{i}; %3d matrix, ordered ind, mut, init
    l=length(vs{i});
    mysls = zeros(14,l);
    myds = zeros(14,l);
    mynormModeEigs = zeros(14,l);
    myavgeigs = zeros(14,l);
    v=vs{i};
    for k = 1:l
        for j = 1:14
            p=ps(:,j,k);
            mysls(j,k)=simploc(p);
            myds(j,k) = totalVar(v,p);
            [~,m] = max(p);
            mynormModeEigs(j,k) = v(m)/max(v); 
            myavgeigs(j,k)=(v'*p)/(v'*v);
        end
    end
    isosls{i}=mysls;
    isods{i}=myds;
    isonormModeEigs{i}=mynormModeEigs;
    isoavgeigs{i}=myavgeigs;
end

hipstruct.isopss=isopss;
hipstruct.isosls=isosls;
hipstruct.isods = isods;
hipstruct.isonormModeEigs = isonormModeEigs;
hipstruct.isoavgeigs = isoavgeigs;
save("hipstruct.mat", "hipstruct");

%% 13. final save

save("background-4.mat","russianstruct","russianstruct2","indsss3","lowpstruct","hipstruct");