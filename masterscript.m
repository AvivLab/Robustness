
%load('russianstruct.mat');
%load('russianstruct2.mat');
%load('indsss3.mat');
%load('sweepvs2.mat')
%load('sweepps3.mat');
%load('disweep5.mat'); %missing this one
%load('lowpstruct.mat');
%load('hipstruct.mat'); 
%% 
load('mus.mat');
load('background-4.mat');
%%
%generate a plot of representative landscapes and their eigencentralities
figure(); % figure 1
%plot 1: square in Z^2
A1=zeros(50,50);
for i=1:50
    for j=1:50
        A1(i,j)=sin(pi*i/51)*sin(pi*j/51);
    end
end
%s=sum(sum(A1));
m=max(max(A1));
A1=A1/m;
h1=subplot(2,3,1);
colorplot(A1,1:51,1:51,0,h1);
title(h1,"(A)");
set(gca,'fontweight','bold','fontsize',20)



%plot 2: geometric Russian Roulette

h2=subplot(2,3,2);
inds2=getrandgrid([50,50],0.2);
plotgrid(50,inds2,[],1,h2);
title(h2,"(B)");
set(gca,'fontweight','bold','fontsize',20)
%plot 3: Mesa

h3=subplot(2,3,[3,6]);
A=mesaAdj(100);
A=A(1:10,1:10);
vv=topeig(A);
vv=vv/max(vv);
plot(h3,0:9,vv,LineWidth=1.5);
xlabel(h3,"Hamming distance from center");
ylabel(h3,"Normalized density");
title(h3,"(E)");
set(gca,'fontweight','bold','fontsize',20)

%plot 4: genetic Russian Roulette, low p
h4=subplot(2,3,4);
%inds4=indsss3{2,2}{2};
inds4 = indsss3{2,14}{2};
n=7; %I think
A4=getAdj(2*ones(7,1),0,inds4);
p4=plotgraph(A4,topeig(A4),h4);
p4.LineWidth=1.5;
xticks(h4,[]);
yticks(h4,[]);
title(h4,"(C)");
set(gca,'fontweight','bold','fontsize',20)

%plot 5: genetic Russian Roullete, high p
h5=subplot(2,3,5);
indsss2=russianstruct2.indsss;
vss2 = russianstruct2.vss;
inds5=indsss2{1,4}{1};
A5=getAdj(2*ones(6,1),0,inds5);
%A5.LineWidth=1.5;
p5=plotgraph(A5,topeig(A5),h5);
p5.LineWidth=1.5;
xticks(h5,[]);
yticks(h5,[]);
title(h5,"(D)");
set(gca,'fontweight','bold','fontsize',20)
sgtitle('Eigencentrality Distributions','FontWeight','bold','fontsize',28)
%% localizations
figure(); %figure 2

%plot 1: localization on geometric Russian Roulette.
h1=subplot(1,3,1);
nsls=russianstruct.nsls;
nslsmeans=mean(nsls,3);
nslsmeans=nslsmeans(:,21:-1:1);
colorplot(nslsmeans,0.7:0.01:0.91,10:51,1,h1);
xlabel(h1,'viable probability');
ylabel(h1,'side length of grid');
title(h1, 'Geometric Russian roulette');
set(gca,'fontweight','bold','fontsize',20)

%plot 2: localization on genetic Russian Roulette.
h2=subplot(1,3,2);
nsls2=russianstruct2.nsls;
nsls2means=mean(nsls2,3);
nsls2means=nsls2means(:,15:-1:1);
colorplot(nsls2means,0.15:0.05:0.95,6:13,1,h2);
xlabel(h2,'viable probability');
ylabel(h2,'dimension');
title(h2,'Genetic Russian roulette');
set(gca,'fontweight','bold','fontsize',20)

%plot 3: localization on mesa landscapes.
h3=subplot(1,3,3);
[mesasls2,mesansls2]=mesasl(20:50,20);
colorplot(mesansls2,0:21,20:51,1,h3)
xlabel(h3,'viable threshold');
ylabel(h3,'dimension');
title(h3,'Mesa Landscape');
set(gca,'fontweight','bold','fontsize',20)

%%
%robustness, initial v final.

indsss2=russianstruct2.indsss;

figure(); %figure 3

%plot 1: geometric Russian Roulette
h1=subplot(2,2,1);
indsss=russianstruct.indsss;
rob0s=russianstruct.rob0s;
rob1s=russianstruct.rob1s;
pss=(0.1:0.01:0.3)';
pss=pss*ones(1,50);
pss=reshape(pss,[1050,1]);
plot(h1,1-pss,reshape(rob1s(41,:,:),[1050,1]),'o', 'MarkerFaceColor', 'b');
hold on;
plot(h1, 1-pss,reshape(rob0s(41,:,:),[1050,1]),"or", 'MarkerFaceColor', 'r');
axis(h1, [0.69,0.91,0.5,1])
legend(h1, 'final population robustness','initial population robustness','Location','southeast','FontWeight','bold','fontsize',18)
xlabel(h1, 'viable probability');
ylabel(h1, 'population robustness');
title(h1, 'Geometric Russian roulette');
set(gca,'fontweight','bold','fontsize',20)

%plot 2: genetic russian roulette
h2=subplot(2,2,2);
rob0s2=russianstruct2.rob0s;
rob1s2=russianstruct2.rob1s;
pss2=(0.1:0.05:0.8)';
pss2=pss2*ones(1,50);
pss2=reshape(pss2,[750,1]);
plot(h2,1-pss2,reshape(rob1s2(7,:,:),[750,1]),'o', 'MarkerFaceColor', 'b');
hold on;
plot(h2,1-pss2,reshape(rob0s2(7,:,:),[750,1]),'or', 'MarkerFaceColor', 'r');
axis(h2,[0.15,0.95,0,1])
legend(h2, 'final population robustness','initial population robustness','Location','southeast','FontWeight','bold','fontsize',18)
xlabel(h2,'viable probability','FontWeight','bold','fontsize',20);
ylabel(h2,'population robustness','FontWeight','bold','fontsize',20);
title(h2,'Genetic Russian roulette','FontWeight','bold','fontsize',20);
set(gca,'fontweight','bold','fontsize',20)

%individual robustness

%1: genetic landscape, low p
h3=subplot(2,2,3);
indss=indsss2{7,15};
myrobs=[];
myeigs=[];
for i=1:50
   inds=indss{i};
   myA=getAdj(2*ones(12,1),0,inds);
   myeig=topeig(myA);
   l=length(inds);
   myrob=myA*ones(l,1);
   %myeig=vss2{7,15}{i}';
   myeig=myeig/max(myeig);
   myrobs=[myrobs;myrob];
   myeigs=[myeigs;myeig];
end
bp1=boxplot(h3,myeigs,myrobs);
set(bp1,{'linew'},{1.5})
title(h3,"Genetic (n=12, p=0.2)");
xlabel(h3,"Number of viable neighbors");
ylabel(h3,"Normalized eigencentrality");
set(gca,'fontweight','bold','fontsize',20)

h4=subplot(2,2,4);
indss2=indsss2{5,4};
myrobs2=[];
myeigs2=[];
for i=1:50
   inds=indss2{i};
   myA=getAdj(2*ones(10,1),0,inds);
   myeig=topeig(myA);
   l=length(inds);
   myrob=myA*ones(l,1);
   %myeig=vss2{5,4}{i};
   myeig=myeig/max(myeig);
   myrobs2=[myrobs2;myrob];
   myeigs2=[myeigs2;myeig];
end
bp2=boxplot(h4,myeigs2,myrobs2);
set(bp2,{'linew'},{1.5})
title(h4,"Genetic (n=10, p=0.75)");
xlabel(h4,"Number of viable neighbors");
ylabel(h4,"Normalized eigencentrality");
set(gca,'fontweight','bold','fontsize',20)

%%
%mutation-recombination dynamics

%localization plot
figure(); %figure 4

h1=subplot(1,3,1);
plot(h1,mus,lowpstruct.sls,LineWidth=1.5);
set(gca,'fontweight','bold','fontsize',20)
axis(h1,[0,0.5,0,1]);
%xscale(h1,'log');
h1i=axes('Position', [0.2,0.4,0.1,0.3]);
plot(h1i,mus(9:14),lowpstruct.sls(9:14,:));
xscale(h1i,"log")
set(gca,'fontweight','bold','fontsize',16)
LimitsX = xlim;
LimitsY = ylim;
%title(h1,{'(A) Low-p landscape,', 'uniform starting population'},'HorizontalAlignment', 'left', 'position', [0, LimitsY(2)],'FontWeight','bold','fontsize',12);
title(h1,{'(A) Low-p landscape,', 'uniform starting population'});
xlabel(h1,"Mutation rate");
ylabel(h1,"Localization");
set(gca,'fontweight','bold','fontsize',20)

h2=subplot(1,3,2);
%plot(h2,mus, lowpstruct.isosls);
%axis(h2,[0,0.5,0,1]);
%hold on;
%plot(h2, mus, lowpstruct.sls(:,1),'--r','LineWidth',2);

plot(h2,mus(1:14),hipstruct.sls(1:14,:),LineWidth=1.5);
axis(h2,[0,0.5,0.004,0.022]);
set(gca,'fontweight','bold','fontsize',20)
LimitsX = xlim; 
LimitsY = ylim;
h2i=axes('Position',[0.5,0.4,0.1,0.3]);
plot(h2i,mus(9:14),hipstruct.sls(9:14,:));
xscale(h2i,"log")

axis(h2,[0,0.5,0.004,0.022]);
set(gca,'fontweight','bold','fontsize',16)
title(h2,{'(B) High-p landscape,', 'uniform starting population'});
xlabel(h2,"Mutation rate");
ylabel(h2,'Localization');
set(gca,'fontweight','bold','fontsize',20);

h3=subplot(1,3,3);
x=[];
for i=1:50
x=[x,lowpstruct.isosls{i}-lowpstruct.sls(:,i)];
end
quantplot(h3,x,mus);
LimitsX = xlim;
LimitsY = ylim;
title(h3,{'(C) Low-p landscape,', 'isogenic starting population'});
xlabel(h3,"Mutation rate");
ylabel(h3,"Localization");
axis(h3,[0,0.5,-0.1,0.8]);
set(gca,'fontweight','bold','fontsize',20);

sgtitle('Localization of stationary distributions under different conditions','FontWeight','bold','fontsize',28)

%%
%x=[];
%for i=1:50
%x=[x,hipstruct.isosls{i}-hipstruct.sls(:,i)];
%end
%quants=quantile(x,[0.05,0.5,0.95],2);
%y1=quants(:,1)';
%y2=quants(:,3)';
%figure();
%p=patch([mus fliplr(mus)], [y1 fliplr(y2)], 'cyan');
%hold on
%plot(mus, quants(:,2),'r')

%distances plots
figure(); %figure  FigS1
h1=subplot(1,3,1);
plot(h1,mus,lowpstruct.ds,LineWidth=1.5);
title(h1,{'(A) Low-p landscape,', 'uniform starting population'});
xlabel(h1,"Mutation rate");
%ylabel(h1,"Localization",'FontWeight','bold','fontsize',20);
set(gca,'fontweight','bold','fontsize',20)

h2=subplot(1,3,2);
plot(h2,mus, hipstruct.ds,LineWidth=1.5);
title(h2,{'(B) High-p landscape,', 'uniform starting population'});
xlabel(h2,"Mutation rate");
%ylabel(h2,"Localization",'FontWeight','bold','fontsize',20);
set(gca,'fontweight','bold','fontsize',20)

h2i=axes('Position',[0.5,0.4,0.1,0.3]);
plot(h2i,mus(9:14),hipstruct.ds(9:14,:));
set(gca,'fontweight','bold','fontsize',16)

h3=subplot(1,3,3);
x=[];
for i=1:50
x=[x,lowpstruct.isods{i}-lowpstruct.ds(:,i)];
end
quantplot(h3,x,mus);
title(h3,{'(C) Low-p landscape,', 'isogenic starting population'});
xlabel(h3,"Mutation rate");
%ylabel(h3,"Localization",'FontWeight','bold','fontsize',20);
set(gca,'fontweight','bold','fontsize',20)

sgtitle('Distance of stationary distribution to eigencentrality under different conditions','FontWeight','bold','fontsize',28 )


%%
%average eigencentrality plots
figure(); %figure 5
h1=subplot(1,3,1);
plot(h1,mus,lowpstruct.avgeigs,LineWidth=1.5);
hold on
x=lowpstruct.avgeigs;
y=mean(x');
p=plot(h1,mus,y);
p.Color="black";
p.LineStyle="--";
p.LineWidth=3;
baselinez=zeros(50,1);
for i=1:50
    v=lowpstruct.vs{i};
    %A=getAdj(2*ones(10,1),0,lowpstruct.vs{i});
    %eigs=topeig(A);
    baselinez(i)=1/(length(v)*(v')*v);
end
q=plot(h1,mus,mean(baselinez)*ones(1,14));
q.LineWidth=2;
q.Color="red";
q.LineStyle="--";
lgd=legend(h1,[p,q],["Average","Baseline"],'FontWeight','bold','fontsize',18);
%lgd.FontSize=18;
title(h1,{'(A) Low-p landscape,', 'uniform starting population'});
xlabel(h1,"Mutation rate");
%ylabel(h1,"Localization",'FontWeight','bold','fontsize',12);
set(gca,'fontweight','bold','fontsize',20)

h2=subplot(1,3,2);
plot(h2,mus, hipstruct.avgeigs);
hold on
x=hipstruct.avgeigs;
y=mean(x');
%p=plot(h2,mus,y);
%p.Color="black";
%p.LineStyle="--";
%p.LineWidth=3;
baselinez2=zeros(50,1);
for i=1:50
    v=hipstruct.vs{i};
    %A=getAdj(2*ones(8,1),0,hipstruct.vs{i});
    %eigs=topeig(A);
    baselinez2(i)=1/(length(v)*(v')*v);
end
q=plot(h2,mus,mean(baselinez2)*ones(1,14));
q.LineWidth=2;
q.Color="red";
q.LineStyle="--";
lgd2=legend(h2,q,"Baseline",'FontWeight','bold','fontsize',18);
%lgd2.FontSize=18;
title(h2,{'(B) High-p landscape,', 'uniform starting population'});
xlabel(h2,"Mutation rate");
%ylabel(h2,"Localization",'FontWeight','bold','fontsize',12);
set(gca,'fontweight','bold','fontsize',20)


h3=subplot(1,3,3);
x=[];
for i=1:50
x=[x,lowpstruct.isoavgeigs{i}-lowpstruct.avgeigs(:,i)];
end
quants=quantile(x,[0.05,0.1,0.25,0.5,0.75,0.95],2);
quantplot(h3,x,mus);
title(h3,{'(C) Low-p landscape,', 'isogenic starting population'});
xlabel(h3,"Mutation rate");
%ylabel(h3,"Localization",'FontWeight','bold','fontsize',12);
set(gca,'fontweight','bold','fontsize',20)

sgtitle('Average Normalized Eigencentrality','FontWeight','bold','fontsize',28)
%%
%eigencentrality of mode

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

figure(); %Figure S2: Eigencentrality of the mode, normalized so that 1 is the maximum possible value.
h1=subplot(1,3,1);
x=lowpstruct.normModeEigs';
plot(h1,mus,x,LineWidth=1.5);
hold on;
%z=(x==1);
%w=sum(z);
%y1=1-w/2000;
%y2=ones(1,14);
y=mean(x);
p1=plot(h1,mus,y);
p1.Color="black";
p1.LineStyle="--";
p1.LineWidth=3;
q=plot(h1,mus,mean(eigz)*ones(1,14));
q.LineWidth=2;
q.Color="red";
q.LineStyle="--";
title(h1,{'(A) Low-p landscape,', 'uniform starting population'});
xlabel(h1,"Mutation rate");
%ylabel(h1,"Localization",'FontWeight','bold','fontsize',12);
set(gca,'fontweight','bold','fontsize',20)

%yyaxis right
%p=patch([mus fliplr(mus)], [y1 fliplr(y2)], 'cyan');
%p.FaceAlpha=0.1;
%axis([0 0.5 0.75 1])
%yticks([y1(1), 1])
%yticklabels({'47','0'})
%ylabel('Number of populations out of 50 with maximum mode eigenvalue')
%yyaxis left
%ylabel('Normalized eigenvalue of the mode')
%lgd=legend(h1,[p1,q],{"Average","Baseline"});
%lgd.FontSize=11;
%lgd.Location='southeast';

h2=subplot(1,3,2);
x=hipstruct.normModeEigs';
plot(h2,mus,x,LineWidth=1.5);
axis(h1,[0,0.5,0,1]);
hold on;
%z=(x==1);
%w=sum(z);
%y1=1-w/2000;
y=mean(x);
p1=plot(h2,mus,y);
p1.Color="black";
p1.LineStyle="--";
p1.LineWidth=3;
q=plot(h2,mus,mean(eigz2)*ones(1,14));
axis(h1,[0,0.5,0,1]);
q.LineWidth=2;
q.Color="red";
q.LineStyle="--";
title(h2,{'(B) High-p landscape,', 'uniform starting population'});
xlabel(h2,"Mutation rate");
%ylabel(h2,"Localization",'FontWeight','bold','fontsize',12);
set(gca,'fontweight','bold','fontsize',20)


%yyaxis right
%p=patch([mus fliplr(mus)], [y1 fliplr(y2)], 'cyan');
%p.FaceAlpha=0.1;
%axis([0 0.5 0.75 1])
%yticks([y1(1), 1])
%yticklabels({'44','0'})
%ylabel('Number of populations out of 50 with maximum mode eigenvalue')
%yyaxis left
%ylabel('Normalized eigenvalue of the mode')
%lgd2=legend(h2,[p1,q],{"Average","Baseline"});
%lgd2.FontSize=11;
%lgd2.Location='southeast';


h3=subplot(1,3,3);
x=[];
for i=1:50
x=[x,lowpstruct.isonormModeEigs{i}-lowpstruct.normModeEigs(:,i)];
end
quantplot(h3,x,mus);
axis(h1,[0,0.5,0,1]);
title(h3,{'(C) Low-p landscape,', 'isogenic starting population'});
xlabel(h3,"Mutation rate");
%ylabel(h3,"Localization",'FontWeight','bold','fontsize',12);
set(gca,'fontweight','bold','fontsize',20)

sgtitle('Normalized Eigencentrality of the Mode','FontWeight','bold','fontsize',28);

%low p
%vs=indssp;
%pss=psss;
%figure();
%1:eigdistsweep
%h1=subplot(2,2,1);
%eigdist=getEigDists(vs,pss,10);
%plot(h1,mus,eigdist)

%2: avgeigsweep
%h2=subplot(2,2,2);
%[~,normAvgEigs]=avgeigcent(vs,10,pss);
%plot(h2,mus,normAvgEigs)

%entropysweep
% entropies=zeros(50,14);
% for i=1:50
%     for j=1:14
%        myps=pss{i}(:,j);
%        entropies(i,j)=entropy(myps);
%     end
% end
% plot(mus,entropies);

%3: qsweep
%h3=subplot(2,2,3);
%[modeEigs,normModeEigs]=eigcentofmode(vs,10,pss);
%[~,avgavgqs]=getavgqs(vs);
%plot(h3,(0:100)/100,avgavgqs)
%hold on
%for i=14:-1:1
%plot(h3,(0:100)/100,getqs(normModeEigs(:,i)));
%end

%
%modes=zeros(50,14);
%for i=1:50
%    myinds=vs{i};
%    for j=1:14
%        [a,b]=max(pss{i}(:,j));
%        modes(i,j)=b;
%    end
%end
%moderob=zeros(50,14);
%for i=1:50
%    A=getAdj(2*ones(10,1),0,vs{i});
%    for j=1:14
%       mymode=modes(i,j);
%       moderob(i,j)=sum(A(:,mymode))/10;
%    end
%end
%
%4: peakmaxsweep
%h4=subplot(2,2,4);
%%isopeaks
%%
isopeakfreqs=getPeakFreq(lowpstruct.indss,lowpstruct.isopss,10);
figure(); hold on
plot(-log(mus(1:13)),mean(isopeakfreqs(:,1:13))',"-*b",LineWidth=1.5);
plot([-log(0.004),10],mean(isopeakfreqs(:,13:14)),"--*b",LineWidth=1.5);
%%unifpeak
unifpeakfreqs=getPeakFreq(lowpstruct.indss,lowpstruct.pss,10);
plot(-log(mus(1:13)),mean(unifpeakfreqs(:,1:13))',"-*m",LineWidth=1.5);
plot([-log(0.004),10],mean(unifpeakfreqs(:,13:14)),"--*m",LineWidth=1.5);
%%isomax
isomaxfreqs=getMaxFreqs(lowpstruct.indss,lowpstruct.isopss,10);
plot(-log(mus(1:13)),mean(isomaxfreqs(:,1:13))',"-*r",LineWidth=1.5);
plot([-log(0.004),10],mean(isomaxfreqs(:,13:14)),"--*r",LineWidth=1.5);
%%unifmax
unifmaxfreqs=getMaxFreqs(lowpstruct.indss,lowpstruct.pss,10);
plot(-log(mus(1:13)),mean(unifmaxfreqs(:,1:13))',"-*g",LineWidth=1.5);
plot([-log(0.004),10],mean(unifmaxfreqs(:,13:14)),"--*g",LineWidth=1.5);
%%plot settings
xticks([-log(mus(1:13)),10])
xtickangle(45)
xticklabels({'\mu=0.5','','\mu=0.3','\mu=0.2','\mu=0.1','','\mu=0.06','\mu=0.04','\mu=0.02','','\mu=0.012','\mu=0.008','\mu=0.004','\mu=0'})
%%legend
h = findobj(gca,'Type','line');
legend([h(5),h(7),h(1),h(3)],'Uniform local peak frequency','Isogenic local peak frequency','Uniform absolute peak frequency','Isogenic absolute peak frequency','Location','best');

%%
% Generating Figure 6, convergence to different attractors under different isogenic starting
% conditions. see also attractors.m

%load("background-3.mat");

isops = lowpstruct.isopss{6};
X=squeeze(isops(:,13,:));
inds=lowpstruct.indss{6};


atts = cell(1,7);
groups=zeros(1,53);
atts{6}=[1,2,5,14];
atts{1}=[3,4,13,15,16,17,18,35,39,40,41,42,43,44,45,46,47,48,51,53];
atts{7}=[6,7];
atts{2}=[8,19,20,21,22,24,25,30,49,50];
atts{5}=[9,10,11,23];
atts{4}=[12,26,27,29,32];
atts{3}=[28,31,33,34,36,37,38,52];

for k = 1:7
    for i = 1:length(atts{k})
        groups(atts{k}(i))=k;
    end
end

figure();
hold on;
A=getAdj(2*ones(10,1),0,inds);
G=graph(A==1);
l=length(X);
sgtitle('One Landscape 4 Basins of Attraction','FontWeight','bold','fontsize',28);

for k=1:4
    h=subplot(2,2,k);
    v=X(:,atts{k}(1));
    ph=plot(h,G,'NodeLabel',{},LineWidth=1.5);
    %set(gca,'fontweight','bold','fontsize',20)
    Y=copper(256);
    Y=Y(61:end,:);
    %Y=Y(256:-1:1,:);
    cmap=colormap(h,Y);
    %cmap=colormap(h,sky(256));
    colorinds=round(196*v/max(v));
    colorinds=max(1,colorinds);
    ph.MarkerSize=7;
    for i=1:l
       highlight(ph,i,'NodeColor',cmap(colorinds(i),:));
       if groups(i)~=k
%            highlight(ph,i,'MarkerSize',5, 'Marker','.');
            highlight(ph,i,'MarkerSize',3);
       end
    end
    colorbar(h);
end


%%diploid, commented for now

%{
%diploid without dominance
%%eigdists
diviabless=disweep5{3};
dipss=disweep5{1};
dimus=[1,mus];
flatviabless=cell(1,50);
for i=1:50
   flatviabless{i}=di2flat(diviabless{i},5); 
end
dieigdist=getEigDists(flatviabless,dipss,10);
figure(); plot(dimus,dieigdist)

%%avgeigs
[~,dinormAvgEigs]=avgeigcent(flatviabless,10,dipss);
figure(); hold on;
plot(dimus,dinormAvgEigs)

%%qs
[~,dinormModeEigs]=eigcentofmode(flatviabless,10,dipss);
[~,diavgavgqs]=getavgqs(flatviabless);
figure(); plot((0:100)/100,diavgavgqs)
hold on
for i=15:-1:1
plot((0:100)/100,getqs(dinormModeEigs(:,i)));
end

%confidence intervals for meanmodeeig
figure();
for i=1:14
[mu,d]=getci(normModeEigs(:,i),0.05);
plot([mu-d,mu,mu+d],[i,i,i],"*-");
hold on
end
alleigs=[];
for i=1:50
myeig=topeig(getAdj(2*ones(10,1),0,vs{i}));
myeig=myeig/max(myeig);
alleigs=[alleigs;myeig];
end
[cmu,cd]=getci(alleigs,0.05);
plot([cmu-cd,cmu,cmu+cd],[15,15,15],"*-");
%}
%%
% Fifure S3
drawSubdividedCube(2)
%