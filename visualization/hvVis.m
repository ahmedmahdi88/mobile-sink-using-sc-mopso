function hvVis()
%% loading results
loadData;
%% finding HV for each scenario
objsCouples=[1 2;1 3;1 4;1 5;2 3;2 4;2 5;3 4;3 5];
for s=1:10
for i=1:9
indes=objsCouples(i,:);
hvsc(i)=HyperVolume(pfsc{s}(:,indes));
hvmo(i)=HyperVolume(pfmo{s}(:,indes));
hvmmo(i)=HyperVolume(pfmmo{s}(:,indes));
hvn2(i)=HyperVolume(pfn2{s}(:,indes));
end
mhvsc(s)=mean(hvsc);
mhvmo(s)=mean(hvmo);
mhvmmo(s)=mean(hvmmo);
mhvn2(s)=mean(hvn2);
end
%% boxPlot
figure;
ax=boxplot([mhvsc',mhvmo',mhvmmo',mhvn2'],...
    'Labels',{'HSC-MOPSO','MOPSO','m-MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('HV comparison boxplot within 10 scenarios');
%% end