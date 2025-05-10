function  samplinggrid(N,k,n,p,T,mu)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    inds=getrandgrid([n,n],p);
    l=length(inds);
    figure();
    h=axes();
    v = VideoWriter('samplinggrid6.avi');
    v.FrameRate=20;
    open(v);
    %A=getAdj([n,n],1,inds);
    %S=sparse(A);
    %B=(1-mu)*eye(l)+mu/4*A;
    pairs=zeros(l,2);
    %eps=0;
    for i=1:l
        pairs(i,:)= ind2tup([n,n],inds(i));
    end
    fulladj=getSemifullAdj([n,n],inds,1);
    ps=ones(l,1)/l;
    plotgrid2(n,pairs,ps,h);
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
                  k=unidrnd(4,1);
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
        plotgrid2part(pairs(todraw,:),ps(todraw),h);
        lastdrawn=active;
        frame=getframe;
        writeVideo(v,frame);
    end
end

