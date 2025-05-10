function corridor(n1,n2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n=n1+n2+1;
A=ones(n);
B=zeros(n^2);
viables=[];
viablepairs=[];
for j=1:n
    for i=1:n
        ind=pair2ind([i,j],n);
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
        for neighb = neighbs
           B(ind,neighb)=1; 
        end
        
        if i==n1+1 && j~= n1+1
            A(i,j)=0;
        else
           viables=[viables,ind]; 
           viablepairs=[viablepairs;i,j];
        end
    end
end
B=B(viables,viables);
m=size(viables,2);
[V,D]=eig(B);
diagonal=zeros(1,m);
for i=1:m
   diagonal(i)=D(i,i); 
end
[~,ind]=sort(diagonal);
V=V(:,ind);
vtop=V(:,m)/sum(V(:,m));
ls=(eye(m)-B/4)\(ones(m,1));
ls=ls/sum(ls);
X=1:n;
Y=1:n;
Z=A;
L=A;
for i = 1:m
    pair= viablepairs(i,:);
    Z(pair(1),pair(2))=vtop(i);
    L(pair(1),pair(2))=ls(i);
end
figure();
surfl(X,Y,Z);
figure();
for i=1:n
    for j=1:n
        if A(i,j)==0
            fill([j,j+1,j+1,j],[i,i,i+1,i+1],'black')
            hold on
        end
    end
end
axis([1,n+1,1,n+1])
hold off


end

function ind = pair2ind(pair,n)
    ind= pair(1)+n*(pair(2)-1);
end

function [i,j] = ind2pair(ind,n)
    i=mod(ind,n)+1;
    j=(ind-i+1)/n+1;
end