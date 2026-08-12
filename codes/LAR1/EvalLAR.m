function cost= EvalLAR(Solution)
global roads timeExp numberOfNodes
load roads
% 1 time unit is 10 ms
coverageZoneRadius = Solution(1);
timePeriodOfCovZonUpd = Solution(2);
experDuration=ConvertToTimeUnit(timeExp);   % [Sec]
rateOfLogging=ConvertToTimeUnit(1);    % [Sec]
experSamples=experDuration/rateOfLogging;
%numberOfNodes=10,20,30,40,...100...200

env=environment(numberOfNodes);

% Define the nodes
for i=1:numberOfNodes
    nodes(i)=node(i,env,coverageZoneRadius,timePeriodOfCovZonUpd);
end

% Initialize location table
for i=1:numberOfNodes
    nodes(i)=nodes(i).InitializeLocationTable(nodes);
end
PlotEnv(env,nodes)
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
        IPDRAvr=1-nanmean(nonzeros(PDR))    % inverse PDR
        E2EDelayAvr=nanmean( E2EDelayAverage)
        overhead(isinf(overhead))=[]
        overheadAvr=nanmean(overhead)
        cost= [IPDRAvr, E2EDelayAvr,overheadAvr ];
if any(isnan(cost))
cost=[inf inf inf];   % the solution is so bad so ignore it
end
