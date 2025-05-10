function reps = getequivs(pss)
%
%Find the number of equivalence classes and a representative of each
%for each parameter setting
%
%Here we assume pss is indexed over varying initial conditions.
%
n=length(pss);
m=size(pss{1},2);
reps=cell(n,m);
eps=0.001;
for i=1:n
    l=size(pss{i},1);
    for j=1:m
        myreps=[];
        count=0;
        for k=1:l
            myp=pss{i}(:,j,k);
            isnew=true;
            for t=1:count
                myrep=myreps(:,t);
                if (totalVar(myrep,myp)<eps)
                    isnew=false;
                end
            end
            if isnew
               myreps=[myreps,myp];
               count=count+1;
            end
        end
        reps{i,j}=myreps;
    end
end

end

