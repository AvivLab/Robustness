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
save("disortstruct2.mat","disortstruct2");

%% FIG 1. Generate diploid fig 1 % Figure 7 of the paper

load("disortstruct.mat");
figure();
h1=subplot(1,2,1);
plot(h1,dimus, disortstruct.avgeigs,LineWidth=1.5);
axis([0, 0.5, 0, 2]);
title(h1,'(A) Average eigencentrality','FontWeight','bold','fontsize',18);
xlabel(h1,"Mutation rate",'FontWeight','bold','fontsize',18);
ylabel(h1,"Average eigencentrality",'FontWeight','bold','fontsize',18);
fontsize(12,"points")
set(gca,'fontweight','bold','fontsize',18)

h2=subplot(1,2,2);
plot(h2,dimus, disortstruct.sls,LineWidth=1.5);
axis([0, 0.5, 0, 1]);
title(h2,'(B) Localization','FontWeight','bold','fontsize',18);
xlabel(h2,"Mutation rate",'FontWeight','bold','fontsize',18);
ylabel(h2,"Localization",'FontWeight','bold','fontsize',18);
fontsize(18,"points")
set(gca,'fontweight','bold','fontsize',18)

%% FIG 1S. supplemental diploid fig 1   % Figure 7 of the paper
load("disortstruct2.mat");
figure();
h1=subplot(1,2,1);
plot(h1,dimus, disortstruct2.avgeigs,LineWidth=1.5);
axis([0, 0.5, 0, 2]);
title(h1,'(A) Average eigencentrality','FontWeight','bold','fontsize',18);
xlabel(h1,"Mutation rate",'FontWeight','bold','fontsize',18);
ylabel(h1,"Average eigencentrality",'FontWeight','bold','fontsize',18);
fontsize(18,"points")
set(gca,'fontweight','bold','fontsize',18)

h2=subplot(1,2,2);
plot(h2,dimus, disortstruct2.sls,LineWidth=1.5);
axis([0, 0.5, 0, 1]);
title(h2,'(B) Localization','FontWeight','bold','fontsize',18);
xlabel(h2,"Mutation rate",'FontWeight','bold','fontsize',18);
ylabel(h2,"Localization",'FontWeight','bold','fontsize',18);
fontsize(18,"points")
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
load("direcstruct2.mat"):�[�2�F�&V77G'V7B��G73��fƖ�G72�F�&V77G'V7B�fƖ�G73��g72�F�&V77G'V7B�g73��73"�F�&V77G'V7C"�73��6�2��W&�2�r�S���G2��W&�2�r�S���fvV�w2��W&�2�r�S�����&���FTV�w2��W&�2�r�S���f�"���S �2�73'��Ӱ�b�g77��Ӱ�f�"���p��2��Ƣ���6�2��ƒ��6����2����G2��ƒ��F�F�f"�b������������������&���FTV�w2��ƒ��b�Ғ����b���fvV�w2��ƒ�҇br���br�b��V��&�Ɨ�VBfW&vP�V�@��V�@�F�&V77G'V7C"�6�3�6�3��F�&V77G'V7C"�fvV�w2�fvV�w3��F�&V77G'V7C"���&���FTV�w2���&���FTV�w3��6fR�&F�&V77G'V7C"��B"�&F�&V77G'V7C""����RRd�r"��B��6�VFVB��F�RW ����B�&F�&V77G'V7B��B"���F��W2���R��"����R�����Ӱ�f�wW&R����7V'��B��"������B�F��W2�F�&V77G'V7B�fvV�w2�����2����R��%ғ��7V'��B��"�"�����B�F��W2�F�&V77G'V7B�6�2�����2����R���Uғ���RRd�r�����B�&F�&V77G'V7B��B"���g72�F�&V77G'V7B�g73��b�g77�Ӱ�73�F�&V77G'V7B�73��2�77�Ӱ��2������"�2���b����r����6�'B�b���f�wW&R������B�㰧��B�����"��""�tƖ�Uv�GF�r��R�� ���B�"����"��""�tƖ�Uv�GF�r��R�����B�r�&r"�tƖ�Uv�GF�r��R����W3����f�"����V�wF��2���b2������r��W0�W�Ɩ�R�������B���"�������"�""���V�@�V�@��VvV�B�#�R�WFF���"�#��WFF���"�&V�vV�6V�G&ƗG�"�����&V$vV��G�R"�tf��EvV�v�Br�v&��Br�vf��G6��Rr�������&V$g&WVV�7�"�tf��EvV�v�Br�v&��Br�vf��G6��Rr�����f��G6��R���'���G2"��6WB�v6�vf��GvV�v�Br�v&��Br�vf��G6��Rr������W2�u�6�F���rŲ�"�R�B�EҐ�&���㰧��B��3S�����3S���"��""�tƖ�Uv�GF�r�ん����B�㰧��B��3S�"����3S���"��""�tƖ�Uv�GF�r�ん����B��3S�r��3S��&r"�tƖ�Uv�GF�r��R���6WB�v6�vf��GvV�v�Br�v&��Br�vf��G6��Rr�b��f�"���3S ��b2������r��W0�W�Ɩ�R�������B���"�������"�""���V�@�V�