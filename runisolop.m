load('indsslop.mat');
load('mus.mat')
isolopsss=fulldynisosweep(10,indsslop,0.1,mus);
save('isolopsss.mat','isolopsss');