f=figure;
ax=boxplot([SC_energVar',MMO_energVar',MO_energVar',N2_energVar'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Energy variance comparison boxplot within 10 random solutions');
ylabel('measure value [watt]');
xlabel('Time [sec]');
set(gca,'FontWeight','bold');