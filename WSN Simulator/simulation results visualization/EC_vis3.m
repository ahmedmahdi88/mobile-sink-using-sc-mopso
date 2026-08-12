f=figure;
% x = min([length(SC_PDR),length(MMO_PDR),length(MO_PDR),length(N2_PDR)]);
ax=plot(SC_energCons,'LineWidth', 2);
hold on;
plot(MMO_energCons,'LineWidth', 2);
plot(MO_energCons,'LineWidth', 2);
plot(N2_energCons,'LineWidth', 2);
   legend({'SC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',10);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Ratio of Energy consumption of Battery - comparison time series for 10 random solutions');
ylabel('measure value [watt] %');
xlabel('Time [sec]');
maxXTicks = max([length(N2_energCons),length(MO_energCons),length(MMO_energCons),length(SC_energCons)]);
xTicks = (0:300:maxXTicks);
set(gca,'xtick',xTicks,'xticklabels',xTicks*0.01);