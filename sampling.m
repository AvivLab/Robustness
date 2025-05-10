function sampling(N,k,p0,T,mu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    p=p0;
    figure();
    v = VideoWriter('sampling9.avi');
    v.FrameRate=20;
    open(v);
    n=length(p);
    fulladj=zeros(n,2);
    %A=(1-mu)*eye(n);
    for i=1:(n-1)
    %   A(i,i+1)=mu/2;
    %   A(i+1,i)=mu/2;
        fulladj(i,2)=i+1;
        fulladj(i+1,1)=i;
    end
    for t=1:T
        for s=1:k
            %p=mnrnd(N,p)';
            %p=p/sum(p);
           xs=mnrnd(N,p);
           ys=xs;
           tomut=1:n;
           tomut=tomut(xs>0);
           for i=tomut
              nmuts=binornd(xs(i),mu);
              ys(i)=ys(i)-nmuts;
              for j=1:nmuts
                  k=unidrnd(2,1);
                  neighbind=fulladj(i,k);
                  if neighbind>0
                     ys(neighbind)=ys(neighbind)+1; 
                  end
              end
           end
           p=ys/sum(ys);
        end
        %plot(p);
        area(p,'LineStyle','None','FaceColor',[0.95,0.6,0.25])
        axis([1 n 0 1]);
        frame=getframe;
        writeVideo(v,frame);
    end
end




