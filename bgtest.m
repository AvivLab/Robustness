[indsss2,vss2]=russiansweep(6:8,0.1:0.05:0.8,5,0,2,0);
russianstruct2=struct;
russianstruct2.indsss=indsss2;
sls2=zeros(3,15,5);
nsls2=zeros(3,15,5);
rob0s = zeros(3,15,5);
rob1s = zeros(3,15,5);
for i=1:3
    n=i+5;
    ns=2*ones(1,n);
    for j=1:15
        %i
        %j
        for k=1:5
            inds=indsss2{i,j}{k};
            A=getAdj(ns,0,inds);
            v=vss2{i,j}{k};
            [sls2(i,j,k),nsls2(i,j,k)]=simploc(v);
            l = length(inds); %length
            d = n; %max degree
            rob0s(i,j,k) = ones(1,l)/d*A*ones(l,1)/l;
            rob1s(i,j,k) = ones(1,l)/d*A*v;
        end
    end
end

%%

figure();
h=subplot(2,3,4);
inds4=indsss2{2,2}{2};
A4=getAdj(2*ones(7,1),0,inds4);
plotgraph(A4,topeig(A4),h);
xticks(h,[]);
yticks(h,[]);

%%
figure(); 
h2=subplot(2,2,2);
rob0s2=rob0s;
rob1s2=rob1s;
pss2=(0.1:0.05:0.8)';
pss2=pss2*ones(1,5);
pss2=reshape(pss2,[75,1]);
plot(h2,1-pss2,reshape(rob1s2(2,:,:),[75,1]),".");
hold on;
plot(h2,1-pss2,reshape(rob0s2(2,:,:),[75,1]),".r");
axis(h2,[0.15,0.95,0,1])
legend(h2, 'final population robustness','initial population robustness','Location','southeast')
xlabel(h2,'viable probability');
ylabel(h2,'population robustness');
title(h2,'Genetic Russian roulette');

%%
load("mus.mat");
lowpstruct = struct;
n=8;
p=0.8;
indss = indsss2{3,15};
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
for i=1:5
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

%% iso sweep
isopss = fulldynisosweep(n,indss,r,mus);
isosls = cell(1,5);
isods = cell(1,5);
isonormModeEigs = cell(1,5);
for i = 1:5
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

%%
isopss = hipstruct.isopss;
isosls = cell(1,50);

for i = 1:50
    ps= isopss{i}; %3d matrix, ordered init,ind,mut
    l=size(isopss{i},1);
    mysls = zeros(14,l);
    for k = 1:l
        for j = 1:14
            p=ps(k,:,j);
            mysls(j,k)=simploc(p);
        end
    end
    isosls{i}=mysls;
end

hipstruct.isosls=isosls;

%% 
indsss = russianstruct2.indsss;
vss=cell(7,15);
for i=1:7
    n=i+5;
    ns=2*ones(1,n);
    i
    for j=1:15
        %i
        %j
        vs=cell(1,50);
        for k=1:50
            inds=indsss{i,j}{k};
            A=getAdj(ns,0,inds);
            v=topeig(A);
            vs{k}=v;
        end
        vss{i,j}=vs;
    end
end

%%

isopss = lowpstruct.isopss;
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
            avgeigs = avgeigcent(indss,n,pss)';
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

%% 

figure();
h3=subplot(1,3,3);
x=[];
for i=1:50
x=[x,lowpstruct.isonormModeEigs{i}-lowpstruct.normModeEigs(:,i)];
end
quantplot(h3,x,mus);

%%
isopeakfreqs=getPeakFreq(lowpstruct.vs,lowpstruct.isopss,10);

%% 

figure(); %figure 7
h1=subplot(1,3,1);
x=lowpstruct.normModeEigs';
plot(h1,mus,x);

%%

eigz=[];
for i=1:50
%A=getAdj(2*ones(10,1),0,lowpstruct.vs{i});
%eigs=topeig(A);
eig = lowpstruct.vs{i};
eig=eig/max(eig);
eigz=[eigz;eig];
end
eigz2=[];
for i=1:50
%A=getAdj(2*ones(8,1),0,hipstruct.vs{i});
%eigs=topeig(A);
eig=hipstruct.vs{i};
eig=eig/max(eig);
eigz2=[eigz2;eig];
end

%% 
hold on;
z=(x==1);
w=sum(z);
y1=1-w/2000; %why divided by 2000?
y2=ones(1,14);
y=mean(x);
p1=plot(h1,mus,y);
p1.Color="black";
p1.LineStyle="--";
p1.LineWidth=3;

%%
q=plot(h1,mus,mean(eigz)*ones(1,14));
q.LineWidth=2;
q.Color="red";
q.LineStyle="--";

%%
yyaxis right
p=patch([mus fliplr(mus)], [y1 fliplr(y2)], 'cyan');
p.FaceAlpha=0.1;
axis([0 0.5 0.75 1])
yticks([y1(1), 1])
yticklabels({'47','0'})
ylabel('Number of populations out of 50 with maximum mode eigenvalue')

%%
%yyaxis left
%ylabel('Normalized eigenvalue of the mode')
lgd=legend(h1,[p1,q],{"Average","Baseline"});
lgd.FontSize=11;
lgd.Location='southeast';

%%

h2=subplot(1,3,2);
x=hipstruct.normModeEigs';
plot(h2,mus,x);
hold on;
z=(x==1);
w=sum(z);
y1=1-w/2000;
y=mean(x);
p1=plot(h2,mus,y);
p1.Color="black";
p1.LineStyle="--";
p1.LineWidth=3;
q=plot(h2,mus,mean(eigz2)*ones(1,14));
q.LineWidth=2;
q.Color="red";
q.LineStyle="--";
yyaxis right
p=patch([mus fliplr(mus)], [y1 fliplr(y2)], 'cyan');
p.FaceAlpha=0.1;
axis([0 0.5 0.75 1])
yticks([y1(1), 1])
yticklabels({'44','0'})
ylabel('Number of populations out of 50 with maximum mode eigenvalue')
%yyaxis left
%ylabel('Normalized eigenvalue of the mode')
lgd2=legend(h2,[p1,q],{"Average","Baseline"});
lgd2.FontSize=11;
lgd2.Location='southeast';

%%
h3=subplot(1,3,3);
x=[];
for i=1:50
x=[x,lowpstruct.isonormModeEigs{i}-lowpstruct.normModeEigs(:,i)];
end
quantplot(h3,x,mus);

%%

