load('disweep2.mat')
load('disweep4.mat')
[pss3,viabless3,ternss3]=randridgedsweep4(5,12,0.1,[0.01,0.05,0.1,0.5,1],0,50,[]);
%we use fewer mutation sweeps than in haploid
%note, we no longer focus on the randridged model
terninds=randridgedinds(10,12,3);  %in base 3
[viableinds,~]=ternary2di(terninds',n);
[viableinds,~]=ternary2di(terninds',10);
terninds=randridgedinds(5,12,3);  %in base 3
[viableinds,~]=ternary2di(terninds',5);
[pss3,viabless3,ternss3]=randridgedsweep4(5,12,0.1,[1,mus],0,50,disweep4{2},1);
[pss3,viabless3,ternss3]=randridgedsweep4(5,12,0.1,[1,mus],0,50,disweep4{3},1);
disweep5={pss3,disweep4{2},viabless3};
diviabless=disweep5{3};
dipss=disweep5{1};
dimus=[1,mus];
flatviabless=di2flat(diviabless,5);
dieigdist=getEigDists(flatviabless,dipss,10);
flatviabless=cell(1,50);
for i=1:50
flatviabless{i}=di2flat(diviabless{i},5);
end
dieigdist=getEigDists(flatviabless,dipss,10);
plot(dimus,dieigdist)
figure(); plot(dimus,dieigdist)
[~,dinormAvgEigs]=avgeigcent(diviabless,10,dipss);
figure();
plot(dimus,dinormAvgEigs)
[~,dinormModeEigs]=eigcentofmode(diviabless,10,dipss);
[~,diavgavgqs]=getavgqs(diviabless);
figure(); plot((0:100)/100,diavgavgqs)
hold on
for i=15:-1:1
plot((0:100)/100,getqs(dinormModeEigs(:,i)));
end
[~,dinormModeEigs]=eigcentofmode(flatviabless,10,dipss);
[~,diavgavgqs]=getavgqs(flatviabless);
figure(); plot((0:100)/100,flatavgavgqs)
hold on
for i=15:-1:1
plot((0:100)/100,getqs(dinormModeEigs(:,i)));
end
[~,dinormModeEigs]=eigcentofmode(flatviabless,10,dipss);
[~,diavgavgqs]=getavgqs(flatviabless);
figure(); plot((0:100)/100,diavgavgqs)
hold on
for i=15:-1:1
plot((0:100)/100,getqs(dinormModeEigs(:,i)));
end
[~,dinormAvgEigs]=avgeigcent(flatviabless,10,dipss);
figure(); hold on;
plot(dimus,dinormAvgEigs)
load('sweepvs2.mat')
load('sweepps3.mat');