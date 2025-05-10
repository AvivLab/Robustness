function [ps,robrs,robms,A] = fulldyn(n,inds,r,mu,ps0,T,mode,eps,tovideo)
%mode: 0=full, 1=point, 2=diploid
%eps: if nonzero, a threshold for establishing equilibrium

l=length(inds);
if mode==0
    R=fulltensor(n,inds);
elseif mode==1
    R=pointtensor(n,inds,r);
elseif mode==2
    R=dipointtensor(n/2,inds,r);
    inds=di2flat(inds,n/2); %change to "flat" format for mutation
end


if tovideo
    figure();
   v = VideoWriter('fulldyn5.avi');
   v.FrameRate=20;
   open(v); 
end
tostop=false;
A=getAdj(2*ones(n,1),0,inds);
ps=ps0;
robrs=[];
robms=[];
ps=ps/sum(ps);
myT=0;
oldps=ps;
step=10;
while ~tostop
    myrobms=zeros(1,step);
    myrobrs=zeros(1,step);
    for t=1:step
       %mutation step
       newps=A*ps;
       mysum=sum(newps);
       myrobms(t)=mysum;
       ps=(1-mu)*ps+mu*newps;
       ps=ps/((1-mu)+mu*mysum);
       pstemp=ps;
       for k=1:l
           % recombination step
           ps(k)=pstemp'*R(:,:,k)*pstemp;
       end
       mysum=sum(ps);
       myrobrs(t)=mysum; %factors in r but that's ok?
       ps=ps/mysum;
       if tovideo
        plotgraph(A,ps);
        frame=getframe;
        writeVideo(v,frame);
       end
    end
    robms=[robms,myrobms];
    robrs=[robrs,myrobrs];
    myT=myT+step;
    d=totalVar(oldps,ps);
    if (eps==0 && myT>=T) || (d<eps)
        tostop=true;
    end
    oldps=ps;
    
end
if tovideo
    close(v);
end
end