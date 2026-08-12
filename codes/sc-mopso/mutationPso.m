function pos= mutationPso(pos,mutRatio,lowerBoundPos,higherBoundPos)
L=length(pos);
numberOfMutated=round(L*mutRatio);
mutatedIndices= round(unifrnd(1,L,1,numberOfMutated));
while length(unique(mutatedIndices)) < length(mutatedIndices)
mutatedIndices= round(unifrnd(1,L,1,numberOfMutated));
end
pos(mutatedIndices)=unifrnd(lowerBoundPos,higherBoundPos,1,numberOfMutated);
end