function setCoverageVis()
%% loading results
loadData;
%% finding setCoverage for all scenarios
for s=1:10
C_SC_MO(s)=SetCoverage2(pfsc{s},pfmo{s});
C_MO_SC(s)=SetCoverage2(pfmo{s},pfsc{s});
C_SC_mMO(s)=SetCoverage2(pfsc{s},pfmmo{s});
C_mMO_SC(s)=SetCoverage2(pfmmo{s},pfsc{s});
C_SC_N2(s)=SetCoverage2(pfsc{s},pfn2{s});
C_N2_SC(s)=SetCoverage2(pfn2{s},pfsc{s});
end
%% boxPlot 
f=figure;
ax=boxplot([C_SC_MO',C_MO_SC',C_SC_mMO',C_mMO_SC',C_SC_N2',C_N2_SC'],...
    'Labels',{'C(HSC-MOPSO,MOPSO)','C(MOPSO,HSC-MOPSO)','C(HSC-MOPSO,m-MOPSO)','C(m-MOPSO,HSC-MOPSO)'...
    ,'C(HSC-MOPSO,NSGA-II)','C(NSGA-II,HSC-MOPSO)'});
set(gca,'FontSize',14);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
rotation = 45;
set(gca,'XTickLabelRotation',rotation);
title('set coverage comparison boxplot within 10 scenarios')
%% end
end
