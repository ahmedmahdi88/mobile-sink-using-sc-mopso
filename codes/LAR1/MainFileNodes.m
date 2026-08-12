clc
clear 
close all
global roads
load roads
% 1 time unit is 10 ms
  timeExp =300;  % [sec]
coverageZoneRadius =100;
timePeriodOfCovZonUpd = 1;
experDuration=ConvertToTimeUnit(timeExp);   % [Sec]
rateOfLogging=ConvertToTimeUnit(1);    % [Sec]
experSamples=experDuration/rateOfLogging;
for numberOfNodes=[ 5 10 25 50 75 100 200 400 600 800]
        env=environment(numberOfNodes);

% Define the nodes
for i=1:numberOfNodes
    nodes(i)=node(i,env,coverageZoneRadius,timePeriodOfCovZonUpd);
end

% Initialize location table
for i=1:numberOfNodes
    nodes(i)=nodes(i).InitializeLocationTable(nodes);
end

DefineLoggingVariables;

while experDuration>=timeCounter
    RunSystem;
    if mod(timeCounter,rateOfLogging)==0 
            
        dataCounter=dataCounter+1;
        % Save PDR value
        PDR(dataCounter)=numberOfReceivedPackets/numberOfGeneratedPackets;
        generatedDataPacketArray(dataCounter)=numberOfGeneratedPackets;
        receivededDataPacketArray(dataCounter)=numberOfReceivedPackets;
        clc
        dataCounter
        PDR(1:dataCounter);
        % Save E2E average delay value
       E2EDelayAverage(dataCounter)=mean(E2EDelay(1:E2ECounter));
  
        % Save overhead data
        overhead(dataCounter)=(numberOfRouteRequestPackets+numberOfRouteReplyPackets)/numberOfReceivedPackets;
            
        % Save Energy Data
        energyVariance(dataCounter)=var([nodes.nodeEnergyConsumption]);
        energyMean(dataCounter)=mean([nodes.nodeEnergyConsumption]);
                        
       
    end
end
        AvrPDR=nanmean(PDR);
        E2EDelayAvr=nanmean( E2EDelayAverage);
        overhead(isinf(overhead))=[];
        overheadAvr=nanmean(overhead);
        save([fileparts(pwd) '\results\LAR Results-Nodes ' num2str(numberOfNodes)])

end
