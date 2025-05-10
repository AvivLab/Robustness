function [inds,A] = getConncomp(ns,inds,mode)
    A=getAdj(ns,mode,inds);
    v=topeig(A);
    bin=conncomp(graph(A));
    [~,i]=max(v);
    indinds=bin==bin(i);
    inds=inds(indinds);
    A=A(indinds,indinds);
end

