classdef Node
    properties (SetAccess=private)
        % general parameters
        nodeNumber;        % Node address
        nodeWorkState;     % Takes two values : on or off
        nodeWorkTime       % Saves the time of node life
        nodeEnergyConsumption;   % Represents node battery
        momentalEnergyConsumption; % energy concumeption at the moment
        averageSizeOfPacket;     % [bit]
        % coverage area parameters
        coverageZoneRadius;      % radius of a circle representing the coverage area
        % position parameters
        x;
        y;
        % Data packets buffer
        generatedDataBuffer;    % generated data buffer
        receivedDataBuffer;    % received data buffer
        interArrivalTime;       % inter arrival time
        dataPacketGenerationMean; % data buckets generation mean
        nextTimeOfGeneration;    % next time of generation
        distNode; % destination node
        sendingDistanse; % sending distance for each node
        distRVP; % distenation RVP
        isCH; % Is cluster Head
        battaryPower;
    end
    methods
        function n=Node(nodeNumber,x,y,isCH,distNode,sendingDistanse,distRVP,...
                distCH,nodeCH)
            % general parameters
            n.nodeNumber=nodeNumber;
            n.nodeWorkState=1; % true
            n.nodeEnergyConsumption=0;
            n.momentalEnergyConsumption=0;
            n.averageSizeOfPacket=1;
            n.coverageZoneRadius=40;
            % position parameters
            n.x=x;
            n.y=y;
            % Data packets buffer
            % Buffer of generated Puckets
            n.generatedDataBuffer = struct('maxSize',10,'size',0,'puckets',[]);
            % Buffer of received Buckets
            n.receivedDataBuffer = struct('maxSize',10,'size',0,'puckets',[]);
            %%%%%%% buckets generation
            n.interArrivalTime=convertSecToTimeUnit(0.06);
            n.dataPacketGenerationMean=1;
            n.nextTimeOfGeneration=round(random('exp',n.interArrivalTime));
            n.isCH=isCH;
            n.battaryPower=0.07; % [watt]
            %%%%%%%%
            if ~isCH
                n.distNode=distNode;
                n.sendingDistanse=sendingDistanse;
                n.distRVP=0; % zero means there is no RVP for current node
            else
                n.distNode = 0; % zero if the node is CH
                chNum = nodeCH(nodeNumber);       % CH number
                n.sendingDistanse = distCH(chNum);
                n.distRVP = distRVP(chNum);
            end
            
        end
    end
end
            