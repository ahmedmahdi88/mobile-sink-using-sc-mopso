%% initialization
clear;
clc;
close all;
addpath([cd '/codes']);
prog=0;
wb = waitbar(0,'Please wait...');
%% select algorithm number
% 1- SC-MOPSO
% 2- MOPSO-mutation
% 3- MOPSO
% 4- NSGA2
sns={[2 3 8 4 2 1 1 3 7 5],[11,4,4,4,1,6,3,9,3,1],[2,4,4,4,4,7,7,8,8,1],[7,6,19,50,15,10,1,7,2,12]}
ss =[5 11 1 2 4 7 5 6 3 11];
for algorithmNumber=1:4
    cnt=0;
algorithms={'SC-MOPSO','MOPSO-mutation','MOPSO','NSGA2'};
%% experiments parameters
timeUnit = 10; % time unit [ms]
expTime = convertSecToTimeUnit(100);  % experiance time [sec]
robotVel=10; % robot velocity
numberOfNodes = 15;
%% global variables
defineGlobalVars;
%% loading nodes positions
% cnt=0;
% ss = [1 13 19];
for seed = ss
% seed=1; % seed number
rng(seed);
% for s=[1 1 1 2 ]
cnt=cnt+1;
s=sns{algorithmNumber}(cnt);
    prog=prog+1;
 waitbar(prog/40,wb) 
SC = load([cd '/results/' 'SC-MOPSO' '/scenario-' num2str(seed)]);
env=SC.env;
SC = load([cd '/results/' algorithms{algorithmNumber} '/scenario-' num2str(seed)]);
if algorithmNumber~=4
nonDomInds=find(~[SC.pop.IsDominated]);
paretoSet = SC.pop(nonDomInds);
else
  paretoSet = SC.paretoFront.solutions;
end
solutionNumber = s;%randi(numel(paretoSet)); % solution number 
nodesPos = env.sensors; % nodes position vector
xNodes = nodesPos(1:2:end); % nodes x coordinates
yNodes = nodesPos(2:2:end); % nodes y coordinates
%% determining cluster Heads nodes
sol = paretoSet(solutionNumber).pos; % solution struct
cId = str2num(paretoSet(solutionNumber).classId);
N = cId(1);
nMS = cId(2);
nRVPs = cId(3:end);
%
xCH = sol.CH.x(1:N); % cluster heads x coordinates
yCH = sol.CH.y(1:N); % cluster heads y coordinates
isCH = zeros(size(xNodes)); % node number for each CH
CHNode = zeros(size(xCH)); % node number for each CH
cn = 0;
for n=1:numberOfNodes
    isCH(n) = any((xNodes(n)==xCH) & (yNodes(n)==yCH)); % is the node cluster head or not 
end
% find ch node number
for cchh=1:length(xCH)
    CHNode(cchh)=find(xCH(cchh)==xNodes & yCH(cchh)==yNodes);
end
numberOfAssosiatedNodes = zeros(size(xNodes)); % number of assosiated nodes...
% for each CH, if the node is not CH then the variable will be zero
%% determine the destination node for each node
dist=[]; % distance from each node to the correspondoing CH
nodeCH=[]; % corresponding CH for each node
% computing the distance between each node and each cluster head
mapMat = zeros(length(xNodes),length(xCH));
for nd=1:length(xNodes)
    point1=[xNodes(nd) yNodes(nd)];
    for h=1:length(xCH)
        point2=[xCH(h) yCH(h)];
        mapMat(nd,h)=pdist2(point1,point2);
    end
    [dist(nd),nodeCH(nd)]=min(mapMat(nd,:));
    numberOfAssosiatedNodes(CHNode(nodeCH(nd)))=numberOfAssosiatedNodes(nodeCH(nd))+1;
end
%% determine the corresponding RVP for each CH
% first we need to extract randi vouz points from the solution
xRVP=[]; % RVP x coordinates
yRVP=[]; % RVP y coordinates
rvpMob=[]; % corresponding mobile sink for each RVP
distCH=[]; % distance between each CH and corresponding RVP
chRvp=[]; % corresponding RVP for each CH
RVP = sol.RVP;
for m=1:nMS
    xRVP=[xRVP RVP(m).x(1:nRVPs(m))];
    yRVP=[yRVP RVP(m).y(1:nRVPs(m))];
    rvpMob=[rvpMob m*ones(1,nRVPs(m))];
    RVP(m).x = RVP(m).x(1:nRVPs(m));
    RVP(m).y = RVP(m).y(1:nRVPs(m));
end
% adjancacy matrix between CHs and RVPs
mapMat2=zeros(length(xCH),length(xRVP));
for ch=1:length(xCH)
    point1=[xCH(ch) yCH(ch)];
    for r=1:length(xRVP)
        point2=[xRVP(r) yRVP(r)];
        mapMat2(ch,r)=pdist2(point1,point2);
    end
    [distCH(ch) chRvp(ch)]=min(mapMat2(ch,:));
end
%% start
%% building Node objects
for i=1:length(xNodes)
    nodes(i) = Node(i,xNodes(i),yNodes(i),isCH(i),CHNode(nodeCH(i)),...
        dist(i),chRvp,distCH,nodeCH);
end
%% building mobile sinks objects
for i=1:nMS
 ms(i)=MobileSink(i,RVP(i).x(1),RVP(i).y(1),robotVel,RVP(i));
end
%% running the system
timeCounter = 0;
numberOfReceivedPucketsInRVP=0;
numberOfReceivedPucketsInCH=0;
numberOfGeneratedPuckets=0;
E2EDelay=[];
dataCounter=0;
momentOfStopping=-inf*ones(1,nMS);
savingTravTimeFlag=ones(1,nMS);
flags=zeros(1,nMS);
TravellingTime=zeros(1,nMS);
numberOfDroppedPuckets=0;
while timeCounter <= expTime && all([nodes.nodeWorkState])
    RunSystem;
    
    timeCounter =timeCounter+1
    if numberOfGeneratedPuckets>0
    PDR_timeSeries(timeCounter) = numberOfReceivedPucketsInRVP/numberOfGeneratedPuckets;
    end
    if numberOfReceivedPucketsInRVP>0
    E2EDelay_timeSeries(timeCounter) = convetTimeUnitToSec(nanmean(E2EDelay));
    end
    if numberOfReceivedPucketsInRVP>0
    energyConsumption_timeSeries(timeCounter)=mean([nodes.nodeEnergyConsumption]*10^-9./nodes(1).battaryPower)*100;
    momentalEnergyConsumption_TS(timeCounter)=mean([nodes.momentalEnergyConsumption]*10^-9./nodes(1).battaryPower)*100;
    energyVar_timeSeries(timeCounter)=0.5*std([nodes([nodes.isCH]>0).momentalEnergyConsumption]*10^-9./[nodes(1).battaryPower]).*100 ...
    +0.5*std([nodes(~[nodes.isCH]>0).momentalEnergyConsumption ]*10^-9./[nodes(1).battaryPower])*100;
dropped_timeSeries(timeCounter)=numberOfDroppedPuckets/numberOfGeneratedPuckets;
    end
%     PDR = numberOfReceivedPucketsInRVP/numberOfGeneratedPuckets;
% E2EDelay = convetTimeUnitToSec(mean(E2EDelay));
% energy consumption
% energyConsumption=mean([nodes.nodeEnergyConsumption]*10^-9./0.05)*100;
% energyVar=0.5*std([nodes([nodes.isCH]>0).nodeEnergyConsumption]*10^-9./[nodes(1).battaryPower])...
%     +0.5*std([nodes(~[nodes.isCH]>0).nodeEnergyConsumption]*10^-9./0.05)*100;
% visualize;
end
PDR = numberOfReceivedPucketsInRVP/numberOfGeneratedPuckets
E2EDelay = convetTimeUnitToSec(nanmean(E2EDelay))
% energy consumption
energyConsumption=mean([nodes.nodeEnergyConsumption]*10^-9./[nodes(1).battaryPower])*100;
momentalEnergyConsumption = mean([nodes.momentalEnergyConsumption]*10^-9./[nodes(1).battaryPower])*100;
energyVar=0.5*std([nodes([nodes.isCH]>0).momentalEnergyConsumption]*10^-9./[nodes(1).battaryPower])...
    +0.5*std([nodes(~[nodes.isCH]>0).momentalEnergyConsumption]*10^-9./[nodes(1).battaryPower])*100;
if any(~[nodes.nodeWorkState])
    systemLifeTime=convetTimeUnitToSec(timeCounter)
end
TravellingTime
%%
dir=[cd '/simulation results - timeSeries3/' algorithms{algorithmNumber} '/seed ' num2str(seed)...
    ];
if ~exist(dir)
    mkdir(dir);
end
save([dir '/' algorithms{algorithmNumber} ' sol-number ' num2str(solutionNumber) ]);
end
end
close(wb);