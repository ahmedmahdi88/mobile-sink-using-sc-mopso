function [n,nodes]=communication(n,nodes,rvpMob)
% determine node type
global numberOfReceivedPucketsInCH;
global numberOfReceivedPucketsInRVP;
global timeCounter;
global E2EDelay;
global dataCounter;
global flags;
global numberOfDroppedPuckets

if n.isCH % if the node is CH
    if ~flags(rvpMob(n.distRVP))
        return;
    end
    % sending puckets procedure 
    if rand<0.5
        
        if n.generatedDataBuffer.size>0
                    dataCounter=dataCounter+1;
E2EDelay(dataCounter)=timeCounter-n.generatedDataBuffer.puckets(1).momentOfGeneration;
    n.generatedDataBuffer.puckets(1)=[];
    n.generatedDataBuffer.size = n.generatedDataBuffer.size-1;
        n=n.consumePower();
       numberOfReceivedPucketsInRVP=numberOfReceivedPucketsInRVP+1;
        end
    else 
        if n.receivedDataBuffer.size>0
             dataCounter=dataCounter+1;
E2EDelay(dataCounter)=timeCounter-n.receivedDataBuffer.puckets(1).momentOfGeneration;
    n.receivedDataBuffer.puckets(1)=[];
    n.receivedDataBuffer.size = n.receivedDataBuffer.size-1;
        n=n.consumePower();
      numberOfReceivedPucketsInRVP=numberOfReceivedPucketsInRVP+1;
        end
    end
  % power consumption
else
    if n.generatedDataBuffer.size>0
    n.generatedDataBuffer.puckets(1)=[];
    n.generatedDataBuffer.size=n.generatedDataBuffer.size-1;
    distenationNode = n.distNode;
    if  nodes(distenationNode).receivedDataBuffer.size+1 > ...
            nodes(distenationNode).receivedDataBuffer.maxSize
        nodes(distenationNode).receivedDataBuffer.puckets(1)= [];
        nodes(distenationNode).receivedDataBuffer.size=...
            nodes(distenationNode).receivedDataBuffer.size-1;
        numberOfDroppedPuckets=numberOfDroppedPuckets+1;
    end
    nodes(distenationNode).receivedDataBuffer =...
        nodes(distenationNode).addPucket...
        (nodes(distenationNode).receivedDataBuffer );
     nodes(distenationNode).receivedDataBuffer.size=...
         nodes(distenationNode).receivedDataBuffer.size+1;
     numberOfReceivedPucketsInCH=numberOfReceivedPucketsInCH+1;
    n=n.consumePower();
    end
end
nodes(n.nodeNumber)=n;
end
    