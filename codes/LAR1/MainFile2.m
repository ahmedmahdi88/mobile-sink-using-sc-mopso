clc
clear 
close all
global roads
load roads
% 1 time unit is 10 ms
timeExp=300;
rng(3);
experDuration=ConvertToTimeUnit(timeExp);   % [Sec]
rateOfLogging=ConvertToTimeUnit(10);    % [Sec]
experSamples=experDuration/rateOfLogging;
%numberOfNodes=10,20,30,40,...100...200
numberOfNodes=160 ;
env=environment(numberOfNodes);

% Define the nodes
for i=1:numberOfNodes
    nodes(i)=node(i,env);
end

% Initialize location table
for i=1:numberOfNodes
    nodes(i)=nodes(i).InitializeLocationTable(nodes);
end

DefineLoggingVariables;
figure
while true
    RunSystem;
    if mod(timeCounter,rateOfLogging)==0 
            
        dataCounter=dataCounter+1;
        % Save PDR value
        PDR(dataCounter)=numberOfReceivedPackets/numberOfGeneratedPackets;
        generatedDataPacketArray(dataCounter)=numberOfGeneratedPackets;
        receivededDataPacketArray(dataCounter)=numberOfReceivedPackets;
        clc
        dataCounter
        PDR(1:dataCounter)
            
        % Save E2E average delay value
        E2EDelayAverage(dataCounter)=mean(E2EDelay(1:E2ECounter));
        
        % Save overhead data
        overhead(dataCounter)=(numberOfRouteRequestPackets+numberOfRouteReplyPackets)/numberOfReceivedPackets;
            
        % Save Energy Data
        energyVariance(dataCounter)=var([nodes.nodeEnergyConsumption]);
        energyMean(dataCounter)=mean([nodes.nodeEnergyConsumption]);
                        
        if experDuration<=timeCounter
            clear E2EDelay
            numberOfDroppedNodes=length(find(~[nodes.nodeWorkState]));
            aliveNodes=find([nodes.nodeWorkState]);
            for j=1:length(aliveNodes.disp('Experiment Done'));
            str=['Experiment' num2str(numberOfNodes) '.mat'];
            save(str);
            break;
        end    
    end
    end
end

Result
