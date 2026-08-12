function n=GenerateDataPackets(n,nodes)

global timeCounter numberOfGeneratedPackets numberOfDroppedPackets2; 
if timeCounter<n.nextTimeOfGeneration %|| n.nodeNumber~=31
   return; 
end

% Generate New Data Packets
n.nextTimeOfGeneration=timeCounter+random('poisson',n.interArrivalTime);
numberOfPacket=random('poisson',n.dataPacketGenerationMean);
availableNodes=find([nodes.nodeWorkState]);
availableNodes(availableNodes==n.nodeNumber)=[];
dataPacket=n.dataPacketStructure;
dataPacket.momentOfGeneration=timeCounter;

for i=1:numberOfPacket
    dataPacket.destinationNode=availableNodes(ceil(rand*length(availableNodes)));
    [n.generatedDataBuffer,state]=n.generatedDataBuffer.AddNewPacket(dataPacket);
    if ~state
        numberOfDroppedPackets2=numberOfDroppedPackets2+1;
    end
end
numberOfGeneratedPackets=numberOfGeneratedPackets+numberOfPacket;

end