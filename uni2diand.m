function diinds = uni2diand(inds)
%
%used to generate diploid landscapes where *both* gametes need to be viable
%(i.e. deleterious mutations are dominant).
    l=length(inds);
    diinds=[];
    for i=1:l
        ind1=inds(i);
       for j=1:l
           ind2=inds(j);
           diinds=[diinds; ind1,ind2];
       end
    end
end

