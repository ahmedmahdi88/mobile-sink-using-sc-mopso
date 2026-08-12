global timeCounter numberOfGeneratedPackets numberOfReceivedPackets
global numberOfDroppedPackets1 numberOfDroppedPackets2 numberOfDroppedPackets3
global numberOfRouteRequestPackets numberOfRouteReplyPackets
global E2EDelay E2ECounter

timeCounter=0;
numberOfGeneratedPackets=0;
numberOfReceivedPackets=0;

numberOfDroppedPackets1=0;
numberOfDroppedPackets2=0;
numberOfDroppedPackets3=0;

numberOfRouteRequestPackets=0;
numberOfRouteReplyPackets=0;

generatedDataPacketArray=zeros(1,experSamples);
receivededDataPacketArray=zeros(1,experSamples);
PDR=zeros(1,experSamples);
dataCounter=0;

numberOfSamples=100000;
% Variables to compute E2E delay
E2EDelay=zeros(1,numberOfSamples);        % Delay for each packet
E2EDelayAverage=zeros(1,experSamples);    % Average delay during periodOfComputingPDR
E2ECounter=0;

% Variables to compute overhead
overhead=zeros(1,experSamples);

% Variables to take the energy into account
energyVariance=zeros(1,experSamples);
energyMean=zeros(1,experSamples);
