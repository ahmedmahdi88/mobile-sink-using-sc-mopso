clear;clc;close all;
s=1;
cost=2;
sc = load([cd '/results/SC-MOPSO/scenario-' num2str(s)]);
paretoFront=[];
nonDomInds=find(~[pop.IsDominated]);
SCparetoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
SCparetoFront(p,:)=paretoSet(p).cost;
end
IdxS = find(SCparetoFront(:,5)==cost);
IdxS'
%%%%%%%%%%%%%
mm = load([cd '/results/MOPSO-mutation/scenario-' num2str(s)]);
MMparetoFront=[];
nonDomInds=find(~[pop.IsDominated]);
MMparetoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
MMparetoFront(p,:)=MMparetoSet(p).cost;
end
IdxMM = find(MMparetoFront(:,5)==cost);
IdxMM'
%%%%%%%%%%%%%
m = load([cd '/results/MOPSO/scenario-' num2str(s)]);
paretoFront=[];
nonDomInds=find(~[pop.IsDominated]);
MparetoSet = pop(nonDomInds);
for p=1:numel(MparetoSet)
MparetoFront(p,:)=MparetoSet(p).cost;
end
IdxM = find(MparetoFront(:,5)==cost);
IdxM'
%%%%%%%%%%%%%
n2 = load([cd '/results/NSGA2/scenario-' num2str(s)]);
N2paretoFront=paretoFront.solutionsObjectiveValues;

IdxN = find(N2paretoFront(:,5)==cost);
IdxN'
%%%%%%%%%%%%%
% find the solutions that dominate other algorithms
% dmm=[]; % sc dominates over mm
% dn2=[];
% dm=[];
% mmd = []; % mm dominated by sc
% for i=1:size(SCparetoFront,1)
%     for j=1:size(MMparetoFront,1)
%         if all(SCparetoFront(i,1:4)<=MMparetoFront(i,1:4)) && any(SCparetoFront(i,1:4)<MMparetoFront(i,1:4))
%             dmm = [dmm i ];
%            mmd = [mmd j];
%         end
%     end
% end
% %%%%%%%
% for i=1:size(SCparetoFront,1)
%     for j=1:size(MparetoFront,1)
%         if all(SCparetoFront(i,1:4)<=MparetoFront(i,1:4)) && any(SCparetoFront(i,1:4)<MparetoFront(i,1:4))
%             dmm = [dmm i];
%         end
%     end
% end