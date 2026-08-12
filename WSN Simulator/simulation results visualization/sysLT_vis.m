f=figure;
ax=boxplot([[SC_sysLifeTime]',[MMO_sysLifeTime]',[MO_sysLifeTime]',[N2_sysLifeTime]'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('System Lifetime boxplot within 10 random solutions');
xlabel('algorithms');
ylabel('measure value [sec]');
set(gca,'FontWeight','bold');