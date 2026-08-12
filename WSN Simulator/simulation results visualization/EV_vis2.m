f=figure;
ax=boxplot([SC_energVar',MMO_energVar'],...
    'Labels',{'SC-MOPSO','m-MOPSO'});
set(gca,'FontSize',10);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title(['energy variance comparison boxplot within ' num2str(hsz) ' random solutions where number of mobile sinks = ' num2str(cost)]);