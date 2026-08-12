%% initialization
clear;
clc;
close all;
%% loading the results
% select the cost between [2-->7]
cost =2;
algorithms={'SC-MOPSO','MOPSO-mutation','MOPSO','NSGA2'};
res = load([cd '/res_cost' num2str(cost)]);
res = res.res;
% sc1={res{1:6}}; sc2={res{10}}; sc3={res{12:16}}; sc4={res{18:19}};
sz = length(res);
hsz = sz/2;
SC = {res{1:hsz}};
% mo1={res{21:26}}; mo2={res{30}}; mo3={res{32:36}}; mo4={res{38:39}};
MMO = {res{hsz+1:end}};
% MO = {res{61:90}};
% N2 = {res{91:120}};
%% SC-MOPSO
for i = 1:length(SC)
SC_PDR(i) = SC{i}.PDR;
SC_EDE(i) = SC{i}.E2EDelay;
SC_energCons(i) = SC{i}.energyConsumption;
SC_energVar(i) = SC{i}.energyVar;
try
SC_sysLifeTime(i) = SC{i}.systemLifeTime;
catch
  SC_sysLifeTime(i) = SC{i}.timeCounter -1;
end
SC_travTime(i) = max(SC{i}.TravellingTime);
SC_dropedPucktsRatio(i) = SC{i}.numberOfDroppedPuckets/SC{i}.numberOfGeneratedPuckets;
end
%% MOPSO-mutation
for i = 1:length(MMO)
MMO_PDR(i) = MMO{i}.PDR;
MMO_EDE(i) = MMO{i}.E2EDelay;
MMO_energCons(i) = MMO{i}.energyConsumption;
MMO_energVar(i) = MMO{i}.energyVar;
try
MMO_sysLifeTime(i) = MMO{i}.systemLifeTime;
catch
  MMO_sysLifeTime(i) = MMO{i}.timeCounter -1;
end
MMO_travTime(i) = max(MMO{i}.TravellingTime);
MMO_dropedPucktsRatio(i) = MMO{i}.numberOfDroppedPuckets/MMO{i}.numberOfGeneratedPuckets;
end
%% MOPSO 
% for i = 1:length(MO)
% MO_PDR(i) = MO{i}.PDR;
% MO_EDE(i) = MO{i}.E2EDelay
% MO_energCons(i) = MO{i}.energyConsumption;
% MO_energVar(i) = MO{i}.energyVar;
% try
% MO_sysLifeTime(i) = MO{i}.systemLifeTime;
% catch
%  MO_sysLifeTime(i) = MO{i}.timeCounter -1;
% end
% MO_travTime(i) = max(MO{i}.TravellingTime);
% MO_dropedPucktsRatio(i) = MO{i}.numberOfDroppedPuckets/MO{i}.numberOfGeneratedPuckets;
% end
% %% NSGA2 
% for i = 1:length(N2)
% N2_PDR(i) = N2{i}.PDR;
% N2_EDE(i) = N2{i}.E2EDelay
% N2_energCons(i) = N2{i}.energyConsumption;
% N2_energVar(i) = N2{i}.energyVar;
% try
% N2_sysLifeTime(i) = N2{i}.systemLifeTime;
% catch
%  N2_sysLifeTime(i) = N2{i}.timeCounter -1;
% end
% N2_travTime(i) = max(N2{i}.TravellingTime);
% N2_dropedPucktsRatio(i) = N2{i}.numberOfDroppedPuckets/N2{i}.numberOfGeneratedPuckets;
% end
%% visualization
%% PDR
PDR_vis2;
%% E2E Delay
EDE_vis2;
%% Energy Consumption
EC_vis2;
%% Energy Vaiance
EV_vis2;
%% system lifetime
sysLT_vis2;
%% travelling time
tt_vis2;
%% dropped puckets ratio
dpr_vis2;
%%
