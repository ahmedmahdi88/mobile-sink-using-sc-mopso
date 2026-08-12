f=figure;
ax=boxplot([[SC_dropedPucktsRatio*100]',[MMO_dropedPucktsRatio*100]',[MO_dropedPucktsRatio*100]',[N2_dropedPucktsRatio*100]'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('dropped Puckets Ratio comparison boxplot within 10 random solutions');
xlabel('algorithms');
ylabel('measure value %');
set(gca,'FontWeight','bold');