%% initialization
clear;
clc;
close all;
%% select the cost (number of mobilse sinks cost)
% 2- random cost
% 3- equal cost
costType = 2;
%% loading the results
algorithms={'SC-MOPSO','MOPSO-mutation','MOPSO','NSGA2'};
res = load([cd '/simResults' num2str(costType)]); 
res = res.res;
SC = {res{1:10}};
MMO = {res{11:20}};
MO = {res{21:30}};
N2 = {res{31:40}};
sn =7; % select solution number
%% SC-MOPSO
SC_solutionNumber = sn; % [1-->3]
for i = SC_solutionNumber 
SC_PDR = SC{i}.PDR_timeSeries;
SC_EDE = SC{i}.E2EDelay_timeSeries;
SC_energCons = SC{i}.energyConsumption_timeSeries;
SC_energVar = SC{i}.energyVar_timeSeries;
SC_dropedPucktsRatio = SC{i}.dropped_timeSeries;
try
SC_sysLifeTime = SC{i}.systemLifeTime;
catch
SC_sysLifeTime = SC{i}.timeCounter -1;
end
end
%% MOPSO-mutation
MMO_solutionNumber = sn; % [1-->3]
for i = MMO_solutionNumber
MMO_PDR = MMO{i}.PDR_timeSeries;
MMO_EDE = MMO{i}.E2EDelay_timeSeries;
MMO_energCons = MMO{i}.energyConsumption_timeSeries;
MMO_energVar = MMO{i}.energyVar_timeSeries;
MMO_dropedPucktsRatio = MMO{i}.dropped_timeSeries;
try
MMO_sysLifeTime = MMO{i}.systemLifeTime;
catch
MMO_sysLifeTime = MMO{i}.timeCounter -1;
end
end
%% MOPSO 
MO_solutionNumber = sn; % [1-->3]
for i = MO_solutionNumber
MO_PDR = MO{i}.PDR_timeSeries;
MO_EDE = MO{i}.E2EDelay_timeSeries
MO_energCons = MO{i}.energyConsumption_timeSeries;
MO_energVar = MO{i}.energyVar_timeSeries;
MO_dropedPucktsRatio = MO{i}.dropped_timeSeries;
try
MO_sysLifeTime = MO{i}.systemLifeTime;
catch
MO_sysLifeTime = MO{i}.timeCounter -1;
end
end
%% NSGA2
N2_solutionNumber =sn; % [1-->3]
for i =N2_solutionNumber
N2_PDR = N2{i}.PDR_timeSeries;
N2_EDE = N2{i}.E2EDelay_timeSeries
N2_energCons = N2{i}.energyConsumption_timeSeries;
N2_energVar = N2{i}.energyVar_timeSeries;
N2_dropedPucktsRatio = N2{i}.dropped_timeSeries;
try
N2_sysLifeTime = N2{i}.systemLifeTime;
catch
N2_sysLifeTime = N2{i}.timeCounter -1;
end
end
%% visualization
%% PDR
PDR_vis3;
%% E2E Delay
EDE_vis3;
%% Energy Consumption
EC_vis3;
%% Energy Vaiance
EV_vis3;
% %% system lifetime
% sysLT_vis2;
% %% travelling time
% tt_vis2;
%% dropped puckets ratio
dpr_vis3;
%%
