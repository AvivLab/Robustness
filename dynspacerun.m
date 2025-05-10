n=12;
myns=n*ones(1,2);
p=0.2;
inds=getrandgrid(myns,p);
m=10;
l=length(inds);
ps0=rand(l,m^2);
pss=fulldynspace(n,inds,0.1,0.001,0.001,m,ps0,100000,1);