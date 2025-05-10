n=10;  %10 for speciation on a connected component.
p=0.15;  %0.15
r=0.01;  %0.1
mu=0.001;  %0.001
migr=0.0001; %0.0001
eps=0.0001;  %0.0001
nv=int64(2^n*p);
seed=17; %17
rng(seed);
inds=sort(randperm(2^n,nv));
inds=getConncomp(2*ones(1,10),inds,0);
l=length(inds);
testps=zeros(l,2);
testps(1,1)=1; testps(l,2)=1;
T=10000;  %1000000
mode=1;  %1
pss8=fulldynmigr2(n,inds,r,mu,migr,eps,testps,T,mode);
finalps8=squeeze(pss8(T,:,:));

migrs = (1:0.5:10)*migr;
k = length(migrs);
xs =zeros(1,k);
for i = 1:k
    pss = fulldynmigr2(n,inds,r,mu,migrs(i),eps,testps,T,mode);
    finalps = squeeze(pss(T,:,:));
    xs(i) = finalps(:,1)'*finalps(:,2)/(finalps(:,1)'*finalps(:,1));
end

%% generate figure
figure();
%t = tiledlayout(2,2);
%h=nexttile;
h1=subplot(2,2,1)
A=getAdj(2*ones(n,1),0,inds);
plotgraph(A,finalps8(:,1),h1);
title(h1,"(A) Attractor 1");
set(gca,'fontweight','bold','fontsize',20)
%h=nexttile;
h2=subplot(2,2,2)

plotgraph(A,finalps8(:,2),h2);
title(h2,"(B) Attractor 2");
set(gca,'fontweight','bold','fontsize',20)
%h=nexttile;
h3=subplot(2,2,3)
plot(h3,finalps8(:,1),LineWidth=2.0);
title(h3, "(C) The Two Populations");
xlabel(h3, "Genotype ID");
ylabel(h3, "Frequency");
set(gca,'fontweight','bold','fontsize',20)
hold
plot(finalps8(:,2),LineWidth=2.0);
legend(h3,["Population 1","Population 2"]);
%h=nexttile;
h4=subplot(2,2,4)
plot(h4,migrs,xs,LineWidth=2.0);
title(h4, "(D) Population Alignment");
xlabel(h4, "migration rate");
axis(h4,[0, migrs(end),0,1.1])
set(gca,'fontweight','bold','fontsize',20)


