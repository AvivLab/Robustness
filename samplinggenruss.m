function  samplinggenruss(N,k,n,p,T,mu)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ns=2*ones(1,n);
    inds=getrandgrid(ns,p);
    inds=getConncomp(ns,inds,0);
    l=length(inds);
    figure();
    h=axes();
    v = VideoWriter('samplingruss2.avi');
    v.FrameRate=20;
    open(v);
    fulladj=getSemifullAdj(ns,inds,1);
    d=size(fulladj,2);
    ps=ones(l,1)/l;
    A=getAdj(ns,0,inds);
    myplot=plotgraph(A,ps,h);
    active=true(1,l);
    lastdrawn=true(1,l);
    for t=1:T
        for s=1:k
           xs=mnrnd(N,ps(active));
           ys=zeros(1,l);
           ys(active)=xs;
           newactive=false(1,l);
           newactive(active)=(xs>0);
           myinds=1:l;
           myinds=myinds(newactive);
           for i=myinds
              nmuts=binornd(ys(i),mu);
              ys(i)=ys(i)-nmuts;
              for j=1:nmuts
                  k=unidrnd(d,1);
                  neighbind=fulladj(i,k);
                  if neighbind>0
                     ys(neighbind)=ys(neighbind)+1;
                     newactive(neighbind)=1;
                  end
              end
           end
           ps=ys/sum(ys);
           active=newactive;
        end
        todraw=lastdrawn | active;
        %plotgraph(A,ps,h);
        plotgraph2(myplot,todraw,ps,h);
        lastdrawn=active;
        frame=getframe;
        writeVideo(v,frame);
    end
end

