function infallele(n,m,mu,T)

%m=number of individuals
%n= sequence length

seqs=zeros(m,n,2);
homozyg=zeros(1,T);
for t=1:T
    newseqs=zeros(m,n,2);
    for k=1:m
        %for each individual, replace its gametes
        %with two randomly chosen from the population
        %(no cross-over occurs)
        newseqs(k,:,1)=mutateseq(seqs(randi(m),:,randi(2)),mu);
        newseqs(k,:,2)=mutateseq(seqs(randi(m),:,randi(2)),mu);
        %measure the homozygosity
        if all(newseqs(k,:,1)==newseqs(k,:,2))
            homozyg(t)=homozyg(t)+1;
        end
    end
    homozyg(t)=homozyg(t)/m;
    seqs=newseqs;
end

% inds=zeros(m,2);
% for i=1:m
%     for k=1:2
%         inds(i,k)=tup2ind(n,2*ones(n,1),(1+seqs(i,:,k))');
%     end 
% end

plot(homozyg);
end

function newseq = mutateseq(seq,mu)
    %mutate the sequence
    n=length(seq);
    newseq=seq;
    for i=1:n
        if rand()<mu
            newseq(i)=1-seq(i);
        end
    end
end