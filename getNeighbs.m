function neighbs = getNeighbs(ns,ind,mode)
%GETNEIGHBS Get the neighbors of a specific node in the grid
%  mode=0 : "genetic" -- jump anywhere along a fixed dimension
%  mode=1 : "geometric" -- only adjacent
%  mode=2 : torus -- geometric with wraparound
    d=length(ns);
    neighbs=[];
    tup=ind2tup(ns,ind);
    multipliers=ones(1,d);
    for i=2:d
       multipliers(i)=multipliers(i-1)*ns(i-1);
    end
    for i=1:d
        if mode==0
           for j=1:ns(i)
              if j~= tup(i)
                  newtup=tup;
                  newtup(i)=j;
                  newind=tup2ind(ns,newtup);
                  neighbs=[neighbs,newind]; 
              end
           end
        elseif mode==1
           if tup(i)>1
               neighbs=[neighbs,ind-multipliers(i)];
           end
           if tup(i)<ns(i)
               neighbs=[neighbs,ind+multipliers(i)];
           end       
        end
    end    
end