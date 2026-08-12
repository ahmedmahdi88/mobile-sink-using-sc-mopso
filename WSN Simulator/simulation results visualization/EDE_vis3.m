f=figure;
% x = min([length(SC_PDR),length(MMO_PDR),length(MO_PDR),length(N2_PDR)]);
ax=plot(SC_EDE*0.01,'LineWidth', 2);
hold on;
plot(MMO_EDE*0.01,'LineWidth', 2);
plot(MO_EDE*0.01,'LineWidth', 2);
plot(N2_EDE*0.01,'LineWidth', 2);
   legend({'SC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',10);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('E2E delay comparison time series for 10 random solutions');
ylabel('measure value [sec]');
xlabel('Time [sec]');
maxXTicks = max([length(N2_EDE),length(MO_EDE),length(MMO_EDE),length(SC_EDE)]);
xTicks = (0:300:maxXTicks);
set(gca,'xtick',xTicks,'xticklabels',xTicks*0.01);