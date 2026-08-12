clear;clc;close all
%% set coverage
setCoverageVis();
%% hyper volume
hvVis();
%% RGD
rgdVis();
%% NDS
ndsVis();
%% visualize some solutions in the 2-D environment
% select scenario
scenario=4;
sc=load([cd '/../results/Results_SC/scenario-' num2str(scenario) '/scenario-' num2str(scenario) '.mat' '/scenario-' num2str(scenario) '.mat']);
mo=load([cd '/../results/Results_MOPSO/scenario-' num2str(scenario) '/scenario-' num2str(scenario) '.mat' '/scenario-' num2str(scenario) '.mat']);
mmo=load([cd '/../results/Results_MO_mutation/scenario-' num2str(scenario)  '/scenario-' num2str(scenario) '.mat']);
n2=load([cd '/../results/NSGA2/scenario-' num2str(scenario) '.mat']);
env=sc.env;
pfsc=sc.pop(~[sc.pop.IsDominated]);
pfmo=mo.pop(~[mo.pop.IsDominated]);
pfmmo=mmo.pop(~[mmo.pop.IsDominated]);
pfn2=n2.paretoFront.solutions;

% select solution number
SC_solutionNumber=1;
MO_solutionNumber=1;
MMO_solutionNumber=1;
N2_solutionNumber=1;
% SC-MOPSO visualization
figure;
visualizeSink2D(env,pfsc(SC_solutionNumber).pos,pfsc(SC_solutionNumber).classId);
title('SC-MOPSO');
% MOPSO visualization
figure;
visualizeSink2D(env,pfmo(MO_solutionNumber).pos,pfmo(MO_solutionNumber).classId);
title('MOPSO');
% m-MOPSO visualization
figure;
visualizeSink2D(env,pfmmo(MMO_solutionNumber).pos,pfmmo(MMO_solutionNumber).classId);
title('m-MOPSO');
% NSGA-II visualization

figure;
visualizeSink2D(env,pfn2(N2_solutionNumber).pos,pfn2(N2_solutionNumber).classId);
title('NSGA-II');
%% end