function finalmodes = getfinalmodes(pss)
%
%gets the mode of each stationary distribution in pss
%this is specifically for ps that encode varying initial values.
%
n=length(pss);        %number of landscapes
m=size(pss{1},3);     %number of mutation parameters
finalmodes=cell(1,n);
for i=1:n
    l=size(pss{i},1);
    myfinalmodes=zeros(m,l);
    for j=1:m
        for k=1:l
            myps=pss{i}(k,:,j);
            [~,mymode]=max(myps);
            myfinalmodes(j,k)=mymode;
        end
    end
    finalmodes{i}=myfinalmodes;
end
end

