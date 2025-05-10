function [z,indmap]=merge(A)
%merge a list (with no repetitions)
    z=[];
    [l,k]=size(A);
    indmap=zeros(l,k);
    count=0;
    for i=1:k
        for j=1:l
            cur=A(j,i);
            myfind=find(z==cur,1);
            if isempty(myfind)
                z=[z;cur];
                count=count+1;
                myfind=count;
            end
            indmap(j,i)=myfind;
        end
    end
end