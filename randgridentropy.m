function meane= randgridentropy(n)
%RANDGRIDENTROPY Summary of this function goes here
%   Detailed explanation goes here

del=0.05;
m=400;
emeans=[];
lambmeans=[];
ps=0:del:0.5;
p=0.3;
v1=[];
v2=[];
vp1=[];
vp2=[];
%for p=ps
    es=zeros(m,1);
    lambdas=zeros(m,1);
    %ls=zeros(m,1);
    for i=1:m
        %v=randgrid(n,p,false);
        [B,v,lambda,viablepairs]=randgridhidim(2*ones(1,n),p);
        e=entropy(v);
        es(i)=e;
        %avgl=l'*v;
        %ls(i)=avgl;
        lambdas(i)=lambda;
%         if avgl>8.8 & avgl<9.2
%            if e<0.52
%               v1=v; 
%               vp1=viablepairs;
%            elseif e>0.6
%               v2=v; 
%               vp2=viablepairs;
%            end
%         end
    end
    %emeans=[emeans,mean(es)];
    %lambmeans=[lambmeans,mean(lambdas)];
%end

%histogram(es,50)
meane=mean(es);
%plot(ls,es,'.')
% L = [ones(length(ls),1) ls];
% b = L\es;
% hold on
% reg=L*b;
% Rsq = 1 - sum((es - reg).^2)/sum((es - mean(es)).^2)
% plot(ls,L*b);
% hold off

% plotgrid(n,vp1,v1);
% plotgrid(n,vp2,v2);

%plot(ps,emeans)
%hold on;
%plot(ps,lambmeans)
end