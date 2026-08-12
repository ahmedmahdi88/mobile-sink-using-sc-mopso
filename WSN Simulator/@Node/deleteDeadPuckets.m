function n=deleteDeadPuckets(n)
global timeCounter;
global numberOfDroppedPuckets
%%%%%%%%%%%%%%%%
toDelGen=[];
for g=1:n.generatedDataBuffer.size
    bucketAge=timeCounter-n.generatedDataBuffer.puckets(g).momentOfGeneration;
    if bucketAge > n.generatedDataBuffer.puckets(g).LifeTime;
        toDelGen=[toDelGen g];
        numberOfDroppedPuckets=numberOfDroppedPuckets+1;
    end
end
n.generatedDataBuffer.puckets(toDelGen)=[];
n.generatedDataBuffer.size=n.generatedDataBuffer.size-length(toDelGen);
%%%%%%%%%%%%%%%
toDelRec=[];
for r=1:n.receivedDataBuffer.size
    bucketAge=timeCounter-n.receivedDataBuffer.puckets(r).momentOfGeneration;
    if bucketAge > n.receivedDataBuffer.puckets(r).LifeTime;
       toDelRec=[toDelRec r];
       numberOfDroppedPuckets=numberOfDroppedPuckets+1;
    end
end
 n.receivedDataBuffer.puckets(toDelRec)=[];
 n.receivedDataBuffer.size=n.receivedDataBuffer.size-length(toDelRec);
end