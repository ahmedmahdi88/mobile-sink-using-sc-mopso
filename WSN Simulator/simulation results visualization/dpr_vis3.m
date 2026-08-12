f=figure;
% x = min([length(SC_PDR),length(MMO_PDR),length(MO_PDR),length(N2_PDR)]);
ax=plot(SC_dropedPucktsRatio*100,'LineWidth', 2);
hold on;
plot(MMO_dropedPucktsRatio*100,'LineWidth', 2);
plot(MO_dropedPucktsRatio*100,'LineWidth', 2);
plot(N2_dropedPucktsRatio*100,'LineWidth', 2);
   legend({'SC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',10);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('dropped puckets ratio comparison time series for random solutions');
ylabel('measure value %');
xlabel('Time [sec]');
maxXTicks = max([length(N2_dropedPucktsRatio),length(MO_dropedPucktsRatio),length(MMO_dropedPucktsRatio),length(SC_dropedPucktsRatio)]);
xTicks = (0:300:maxXTicks);
set(gca,'xtick',xTicks,'xticklabels',xTicks*0.01);