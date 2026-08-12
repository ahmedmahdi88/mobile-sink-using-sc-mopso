clc
clear
close all
AddRequiredPaths
for seed = [1:9 11]
    minN=3;
    maxN=9;
    maxMS=2;
    maxMK=2;
    nSensors=15;
clusterRadius=60;
cr=clusterRadius;
sensorRadius=40;
sr=sensorRadius;
rvpRadius=40;
rr=rvpRadius;
    rng(seed);
    currentFolder=pwd;
    scenarioName = ['Scenario-' num2str(seed)];
    path2 =[currentFolder '\..\results\NSGA2\' ];
    if ~exist(path2, 'dir')
       mkdir(path2)
    end
    addpath(path2);
    
    % handle the objective function by its name
    ObjectiveFunction = @AdHoc_updatedMobileSinkObjFun;
    
%     numberOfComponents = higherDim;
   
    lowerBounds = 0;%*ones(1,numberOfComponents);
    upperBounds =  299.9;%*ones(1,numberOfComponents);
    
    MainFile;
    
end
