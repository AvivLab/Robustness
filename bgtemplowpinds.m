%% 1
n=8;
indsss=russiansweep(8,0.8,50,0,2,30,60);
indss=indsss{1};
diIndss = cell(1,50);
for i=1:50
    diIndss{i} = flat2di(indss{i},4);
end

save("templowpinds.mat", "indss","diIndss");
%% 2. random assortment only
dilowpsortstruct = struct;
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
dilowpsortstruct.pss = pss;
dilowpsortstruct.avgeigs = normAvgEigs;
dilowpsortstruct.sls = sls;
dilowpsortstruct.ds = ds;
dilowpsortstruct.vs = vs;
dilowpsortstruct.normModeEigs = normModeEigs;

%% 3.  run the dynamics
dilowpstruct = struct;

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
dilowpstruct.pss = pss;
dilowpstruct.avgeigs = normAvgEigs;
dilowpstruct.sls = sls;
dilowpstruct.ds = ds;
dilowpstruct.vs = vs;
dilowpstruct.normModeEigs = normModeEigs;

%% 4. dominant landscapes
% let's first try to make these big since the other one was so quick
n=6;
indsss=russiansweep(6,0.8,50,0,2,10,20);
indss=indsss{1};
domDiIndss = cell(1,50);
for i = 1:50
    domDiIndss{i} = uni2diand(indss{i});
end

%% 5. recessive

direcstruct=struct; 
n=10;
indsss=russiansweep(5,0.75,50,0,2,8,15);
indss=indsss{1};
recDiIndss = cell(1,50);
for i = 1:50
    recDiIndss{i} = uni2dior(indss{i},n/2);
end

direcstruct.indss=recDiIndss;

%% 6. run the dynamics
r=0; dimus = [0.5,0.2,0.1,0.05,0.01,0.001,0];
pss = fulldynsweep(n,recDiIndss,r,dimus,2);

direcstruct.pss=pss;
save("direcstruct.mat","direcstruct");