function n=generateDataPuckets(n)
global timeCounter;
global numberOfGeneratedPuckets;
global numberOfDroppedPuckets;

if timeCounter<n.nextTimeOfGeneration
    return;
end
n.nextTimeOfGeneration=timeCounter+random('poisson',n.interArrivalTime);
numberOfPuckets=random('poisson',n.dataPacketGenerationMean);
for p=1:numberOfPuckets
if n.generatedDataBuffer.size + 1 > n.generatedDataBuffer.maxSize
    n.generatedDataBuffer.puckets(1)=[];
    n.generatedDataBuffer.size=n.generatedDataBuffer.size-1;
    numberOfDroppedPuckets=numberOfDroppedPuckets+1;
end
n.generatedDataBuffer = n.addPucket(n.generatedDataBuffer);%buffer;
n.generatedDataBuffer.size=n.generatedDataBuffer.size+1;
numberOfGeneratedPuckets=numberOfGeneratedPuckets+1;
end
end
