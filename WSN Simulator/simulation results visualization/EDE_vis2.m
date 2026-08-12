f=figure;
ax=boxplot([SC_EDE',MMO_EDE'],...
    'Labels',{'SC-MOPSO','m-MOPSO'});
set(gca,'FontSize',10);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title(['E2E delay comparison boxplot within ' num2str(hsz) ' random solutions where number of mobile sinks = ' num2str(cost)]);