f=figure;
ax=boxplot([[SC_PDR*100]',[MMO_PDR*100]',[MO_PDR*100]',[N2_PDR*100]'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',14);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('PDR comparison boxplot within 30 random solutions');
xlabel('algorithms');
ylabel('measure value %');
set(gca,'FontWeight','bold');