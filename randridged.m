function [ps,robmsfinal,robrsfinal,viableinds, terninds] = randridged(n,m,rs,mus,bias,toplot,mode,eps,viableinds,init)
%
%Inputs:
%n=the length of the sequences
%m=the number of paths
%r=recombination rate
%bias = bias in the initial distribution (how concentrated)
%toplot = whether or not to plot
%mode: 0=haploid, 1=diploid no dominance, 2=diploid with dominance
%eps = threshold to use for testing equilibrium. If 0, do not test.
%viableinds = if nonempty, use these indices.

terninds=[];

if isempty(viableinds)
    if mode==0
        viableinds=randridgedinds(n,m,2);
    elseif mode==1
        terninds=randridgedinds(n,m,3);  %in base 3
        [viableinds,~]=ternary2di(terninds',n); %convert to diploid, i.e. two indices in base 2
    else
        preinds=randridgedinds(n,m,2); %base 2, 1 representing 00, 2 representing {01,10,11}
        terninds=bi2domtern(preinds,n); %converts to base 3
        [viableinds,~]=ternary2di(terninds',n); %converts to diploid
    end   
end
if mode>0
   n=2*n; 
end
dynmode=(mode>0)+1;
l=length(viableinds);
robmsfinal=[];
robrsfinal=[];
ps=[];
if toplot
%    figure(); plotgraph(A,v0);
end

for i=init
    p0=((1.0-bias)/l)*ones(l,1);
    p0(i)=p0(i)+bias;
    for r=rs
        for mu=mus
            [vrecomb,robrs,robms]=fulldyn(n,viableinds,r,mu,p0,10000,dynmode,eps,false);
            ps=[ps,vrecomb];
            k=length(robms);
            robmsfinal=[robmsfinal,robms(k)];
            robrsfinal=[robrsfinal,robrs(k)];
            if toplot
                figure(); h=plotgraph(A,vrecomb);
                %highlight(h,i);
                %figure(); plot(robms);
            end
        end
    end
end
end
