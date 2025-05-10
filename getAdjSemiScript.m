x=[7,11,15,17,18,21,23,24,26]; 
ns=2*ones(1,5);
B=getAdjSemi(2*ones(1,5),0,x,1/10);
w=topeig(B);
[~,i]=sort(w,"descend");