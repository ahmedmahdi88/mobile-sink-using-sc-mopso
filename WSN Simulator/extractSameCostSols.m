clear;clc;close all;
for s = [1:9 11]
cost=4;
load([cd '/results/SC-MOPSO/scenario-' num2str(s)]);
paretoFront=[];
nonDomInds=find(~[pop.IsDominated]);
paretoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
paretoFront(p,:)=paretoSet(p).cost;
end
IdxS{s} = find(paretoFront(:,5)==cost);

%%%%%%%%%%%%%
load([cd '/results/MOPSO-mutation/scenario-' num2str(s)]);
paretoFront=[];
nonDomInds=find(~[pop.IsDominated]);
paretoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
paretoFront(p,:)=paretoSet(p).cost;
end
IdxMM{s} = find(paretoFront(:,5)==cost);
%%%%%%%%%%%%%
load([cd '/results/MOPSO/scenario-' num2str(s)]);
paretoFront=[];
nonDomInds=find(~[pop.IsDominated]);
paretoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
paretoFront(p,:)=paretoSet(p).cost;
end
IdxM{s} = find(paretoFront(:,5)==cost);
%%%%%%%%%%%%%
load([cd '/results/NSGA2/scenario-' num2str(s)]);
paretoFront=paretoFront.solutionsObjectiveValues;

IdxN{s} = find(paretoFront(:,5)==cost);
end