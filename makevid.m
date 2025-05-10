function makevid(n,inds,pops,vidname)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ps=pops2ps(pops,length(inds));
A=getAdj(2*ones(n,1),0,inds);
T=size(ps,2);
figure();
h=axes();
v = VideoWriter(vidname);
v.FrameRate=50;
open(v);
for t=1:T
    myps=ps(:,t);
    plotgraph(A,myps,h);
    frame=getframe;
    writeVideo(v,frame); 
end

close(v);

end

