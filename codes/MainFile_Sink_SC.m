clear;clc;
AddRequiredPaths;
minN=3;
maxN=9;
maxMS=2;
maxMK=2;
popSize=50;
nobj=5;
minPos=0;
maxPos=299.9;
Vmin=-0.05*(maxPos-minPos);
Vmax=-Vmin;
numberOfIter=300;
mutationProbability=0;
mutationRatio=0.1;
RepSize=popSize;
nGrid=7;
alpha=0.1;
w=0.4;
objfun=@updatedMobileSinkObjFun;
nSensors=15;

clusterRadius=60;
sensorRadius=40;
rvpRadius=40;
for scenario=11:11
rng(scenario);
[countNotValid,countMoved,countMut,countMutRef,cccc,...
    countIsFixed,pop,env,enhancement_timeout,paretoFront...
    ,paretoSet ,NC,classes]=...
    SC_RunAlgorithmSink(RepSize,nGrid,alpha,nSensors,scenario,objfun,...
    popSize,nobj,minPos,maxPos,numberOfIter,w,mutationProbability,...
    mutationRatio,minN,maxN,maxMS,maxMK,clusterRadius,sensorRadius,...
    rvpRadius,Vmin,Vmax);
%%%%%%%%%%%
 currentFolder=pwd;
path2 =[currentFolder '\Results_Sink3\scenario-' num2str(scenario) '\scenario-' num2str(scenario) '.mat' ];
if ~exist(path2, 'dir')
       mkdir(path2)
end
% objFcn=objfunList{scenario};
       save([path2 '\scenario-' num2str(scenario) ],'cccc' ,'paretoFront','paretoSet','NC','classes','enhancement_timeout','popSize','env','pop','countIsFixed');
end