f=figure;
% x = min([length(SC_PDR),length(MMO_PDR),length(MO_PDR),length(N2_PDR)]);
ax=plot(SC_PDR*100,'LineWidth', 2);
hold on;
plot(MMO_PDR*100,'LineWidth', 2);
plot(MO_PDR*100,'LineWidth', 2);
plot(N2_PDR*100,'LineWidth', 2);
   legend({'SC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',10);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('PDR comparison time series for random solutions');
ylabel('measure value %');
xlabel('Time [sec]');
maxXTicks = max([length(N2_PDR),length(MO_PDR),length(SC_PDR),length(MMO_PDR)]);
xTicks = (0:300:maxXTicks);
set(gca,'xtick',xTicks,'xticklabels',xTicks*0.01);