function diinds = uni2dior(inds,n)
%
%Used to generate landscapes where at least one gamete must be viable (so
%deleterious mutations are recessive.
    l=length(inds);
    diinds=[];
    inviable=true(1,2^n);
    inviable(inds)=false(1,l);
    for i=1:l
        ind1=inds(i);
       for j=1:(2^n)
           ind2=j;
           diinds=[diinds; ind1,ind2];
           if inviable(ind2) %to avoid doubles
               diinds=[diinds; ind2,ind1];
           end
       end
    end
end

