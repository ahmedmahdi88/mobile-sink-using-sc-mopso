function  ndsVis()
%% loading results
loadData;
%% 
for s=1:10
    ndsSC(s)=size(pfsc{s},1);
    ndsMO(s)=size(pfmo{s},1);
    ndsMMO(s)=size(pfmmo{s},1);
    ndsN2(s)=size(pfn2{s},1);
end
%% 
figure;
ax=boxplot([ndsSC',ndsMO',ndsMMO',ndsN2'],...
    'Labels',{'HSC-MOPSO','MOPSO','m-MOPSO'...
    ,'NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('NDS comparison boxplot within 10 scenarios');
%%
end