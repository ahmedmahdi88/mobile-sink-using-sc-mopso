f=figure;
ax=boxplot([[SC_energCons]',[MMO_energCons]',[MO_energCons]',[N2_energCons]'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Ratio of Energy consumption of Battery - comparison time series for 10 random solutions');
xlabel('algorithms');
ylabel('measure value [watt] %');
set(gca,'FontWeight','bold');