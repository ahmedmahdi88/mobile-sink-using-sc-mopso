clear;clc;close all;
s=11;
load([cd '/results/SC-MOPSO/scenario-' num2str(s)]);
nonDomInds=find(~[pop.IsDominated]);
paretoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
paretoFront(p,:)=pop(p).cost;
end
plot(paretoFront(:,5),paretoFront(:,4)/100,'b*');
hold on;
plot(paretoFront(:,5),(paretoFront(:,1)+paretoFront(:,2))/10^4,'r*');
plot(paretoFront(:,5),paretoFront(:,3)/10^4,'k*');
%%%%%%%%%%%%%
load([cd '/results/MOPSO-mutation/scenario-' num2str(s)]);
nonDomInds=find(~[pop.IsDominated]);
paretoSet = pop(nonDomInds);
for p=1:numel(paretoSet)
paretoFront(p,:)=pop(p).cost;
end
plot(paretoFront(:,5),paretoFront(:,4)/100,'bo');
hold on;
plot(paretoFront(:,5),(paretoFront(:,1)+paretoFront(:,2))/10^4,'ro');
plot(paretoFront(:,5),paretoFront(:,3)/10^4,'ko');
legend({'travTime_SC','EnerCo_SC','EnerVar_SC','travTime_m','EnerCo_m','EnerVar_m'});
