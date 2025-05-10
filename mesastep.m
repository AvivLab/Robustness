function [w,robr] = mesastep (v,m1,m2)
    n=length(v)-1;
    %assume weightedsum(v)=1
    %v=v/weightedsum(v);
    w= zeros(n+1,1);
    for l=0:n
        for j1=0:l
            for k1=0:(n-l)
                for j2=0:l
                    for k2=0:(n-l)
                        %this represents the situation that we have recomb at position l
                        %parent 1 has j1 1's before l, k1 after
                        %similarly parent 2
                        %Say inherit the length-l part from parent 1
                        p1=nchoosek(n-l,k1)*v(j1+k1+1);
                        p2=nchoosek(l,j2)*v(j2+k2+1);
                        val=j1+k2;
                        contr=nchoosek(val,j1)*nchoosek(n-val,l-j1)*p1*p2/(2^n);
                        if val >= m1 && val<=m2
                            w(val+1)=w(val+1)+contr;
                        end
                    end
                end
            end
        end
    end
    robr=weightedsum(w);
end