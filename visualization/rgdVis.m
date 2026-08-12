function rgdVis()
%% loading results
loadData;
%% finding true ParetoFront for each scenario
for s=1:10
truePareto=find_opt_objs(s,pfsc,pfmo,pfmmo,pfn2);
dsc(s)=GenerationalDistance(pfsc{s},truePareto,2);
dmo(s)=GenerationalDistance(pfmo{s},truePareto,2);
dmmo(s)=GenerationalDistance(pfmmo{s},truePareto,2);
dn2(s)=GenerationalDistance(pfn2{s},truePareto,2);
end
%% boxPlot
figure;
ax=boxplot([dsc',dmo',dmmo',dn2'],...
    'Labels',{'HSC-MOPSO','MOPSO','m-MOPSO'...
    ,'NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('GD comparison boxplot within 10 scenarios');
%% end
