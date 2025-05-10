% Generating Figure 6, convergence to different attractors under different isogenic starting
% conditions.

load("background-3.mat");
isops = lowpstruct.isopss{6};
X=squeeze(isops(:,13,:));
inds=lowpstruct.indss{6};


atts = cell(1,7);
groups=zeros(1,53);
atts{6}=[1,2,5,14];
atts{1}=[3,4,13,15,16,17,18,35,39,40,41,42,43,44,45,46,47,48,51,53];
atts{7}=[6,7];
atts{2}=[8,19,20,21,22,24,25,30,49,50];
atts{5}=[9,10,11,23];
atts{4}=[12,26,27,29,32];
atts{3}=[28,31,33,34,36,37,38,52];

for k = 1:7
    for i = 1:length(atts{k})
        groups(atts{k}(i))=k;
    end
end

%%
figure();
hold on;
A=getAdj(2*ones(10,1),0,inds);
G=graph(A==1);
l=length(X);
sgtitle('One Landscape 4 Basins of Attraction');

for k=1:4
    h=subplot(2,2,k);
    v=X(:,atts{k}(1));
    ph=plot(h,G,'NodeLabel',{});
    Y=copper(256);
    Y=Y(61:end,:);
    %Y=Y(256:-1:1,:);
    cmap=colormap(h,Y);
    %cmap=colormap(h,sky(256));
    colorinds=round(196*v/max(v));
    colorinds=max(1,colorinds);
    ph.MarkerSize=3;
    for i=1:l
       highlight(ph,i,'NodeColor',cmap(colorinds(i),:));
       if groups(i)~=k
            highlight(ph,i,'Marker','.');
       end
    end
    colorbar(h);
end