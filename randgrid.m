function vtop= randgrid(n,p, mu, lowfit, toplot)
%Creates an nxn grid, where each point has a probability p of being removed.
%Calculate the resulting stationary distribution of evolutionary dynamics
%Matrix A will record viability of each point (0/1).
%Matrix B will record the adjacency matrix among viable nodes.
% mu - mutation rate
% lowfit - level of low fitness rather than usual holey landscape lethal (0 fitness).
A=ones(n);
F=zeros(n^2);
B=zeros(n^2);
viables=[];
viablepairs=[];
%lowfit=0.9;
%mu=0.1;
for j=1:n
    for i=1:n
        ind=pair2ind([i,j],n);
        neighbs=getneighbs2(i,j,n);
        for neighb = neighbs
           B(ind,neighb)=1; 
        end
        
        if rand()<p
            A(i,j)=0;
            F(ind,ind)=lowfit;
        else
           F(ind,ind)=1;
           viables=[viables,ind]; 
           viablepairs=[viablepairs;i,j];
        end
    end
end
Bp=B;
B=B(viables,viables);
m=size(viables,2);
[vtop,lamb]=topeig(B);

M=((1-mu)*eye(n^2)+mu/4*Bp)*F;
[vtopp,lambp]=topeig(M);

ls=(eye(m)-B/(2*(n-1)))\(ones(m,1));
ls=ls;
if toplot
    X=1:n;
    Y=1:n;
    Z=A;
    W=zeros(n);
    L=A;
    for i = 1:m
        pair= viablepairs(i,:);
        Z(pair(1),pair(2))=vtop(i);
        L(pair(1),pair(2))=ls(i);
    end
    for ind=1:n^2
        [i,j]=ind2pair(ind,n);
        W(i,j)=vtopp(ind);
    end
    figure();
    surfl(X,Y,Z);
    figure();
    surfl(X,Y,W);
    figure();
    Xp=1:(n+1);
    Yp=1:(n+1);
    Zp=zeros(n+1);
    Zp(1:n,1:n)=Z;
    pcolor(Xp,Yp,Zp)
    cmap= autumn;
    cmap= cmap(64:-1:1,:);
    colormap(cmap);
    colorbar
    axis([1,n+1,1,n+1]);
    hold on
    for i=1:n
        for j=1:n
            if A(i,j)==0
                fill([j,j+1,j+1,j],[i,i,i+1,i+1],'black')
                hold on
            end
        end
    end
    figure()
    pcolor(X,Y,L)
    colormap(cmap);
    colorbar
        hold on
    for i=1:n
        for j=1:n
            if A(i,j)==0
                fill([j,j+1,j+1,j],[i,i,i+1,i+1],'black')
                hold on
            end
        end
    end
    %figure()
    %surf(X,Y,A);
end

end

function ind = pair2ind(pair,n)
%assigns an index from 1 to n^2 for each pair (i,j)
    ind= pair(1)+n*(pair(2)-1);
end

function [i,j] = ind2pair(ind,n)
%converts the index back to a pair (i,j)
    i=mod(ind-1,n)+1;
    j=(ind-i)/n+1;
end

function neighbs= getneighbs1(ind,i,j,n)
        neighbs=[];
        if i>1
           neighbs=[neighbs, ind-1];
        end
        if i<n
           neighbs=[neighbs ,ind+1];
        end
        if j>1
           neighbs=[neighbs, ind-n];
        end
        if j<n
           neighbs=[neighbs, ind+n];
        end
end

function neighbs= getneighbs2(i,j,n)
    neighbs=[];
    for k=1:n
       neighbs=[neighbs,pair2ind([i,k],n)];
       neighbs=[neighbs,pair2ind([k,j],n)];
    end
end
