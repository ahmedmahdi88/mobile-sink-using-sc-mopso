clear;clc;
cf=pwd;
cf(cf=='\')='/';
c=1;
for s=[1:9 11];
    sc=load([cf '/../results/Results_SC/scenario-' num2str(s) '/scenario-' num2str(s) '.mat' '/scenario-' num2str(s) '.mat']);
    mo=load([cf '/../results/Results_MOPSO/scenario-' num2str(s) '/scenario-' num2str(s) '.mat' '/scenario-' num2str(s) '.mat']);
    mmo=load([cf '/../results/Results_MO_mutation/scenario-' num2str(s)  '/scenario-' num2str(s) '.mat']);
    n2=load([cf '/../results/NSGA2/scenario-' num2str(s) '.mat']);
    pfsc{c}=sc.paretoFront;
    pfmo{c}=mo.paretoFront;
    pfmmo{c}=mmo.paretoFront;
    pfn2{c}=n2.paretoFront.solutionsObjectiveValues;
    c=c+1;
end

    
    