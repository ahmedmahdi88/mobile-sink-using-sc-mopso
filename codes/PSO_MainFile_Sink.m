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
RepSize=popSize;
mutationProbability=0.1;
mutationRatio=0.5;
nGrid=7;
alpha=0.1;
w=0.4;
objfun=@AdHoc_updatedMobileSinkObjFun;
nSensors=15;
clusterRadius=60;
sensorRadius=40;
rvpRadius=40;
for scenario=[1:9 11]
    rng(scenario);
[t,countNotValid,countMoved,countMut,countMutRef,cccc,countIsFixed,pop,env,enhancement_timeout,paretoFront,paretoSet ,NC,classes]=RunAlgorithmSink(RepSize,nGrid,alpha,nSensors,scenario,objfun,popSize,nobj,minPos,maxPos,numberOfIter,w,mutationProbability,mutationRatio,minN,maxN,maxMS,maxMK,clusterRadius,sensorRadius,rvpRadius,Vmin,Vmax);
 currentFolder=pwd;
path2 =[currentFolder '\Results_MO_mutation\scenario-' num2str(scenario) ];
if ~exist(path2, 'dir')
       mkdir(path2)
end
objFcn=objfun;

       save([path2 '\scenario-' num2str(scenario) ] ,'t','paretoFront','paretoSet','NC','classes','popSize','pop','objFcn');
end