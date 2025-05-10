load('indsship.mat');
load('mus.mat')
isohipsss=fulldynisosweep(8,indsship,0.1,mus);
save('isohipsss.mat','isohipsss');