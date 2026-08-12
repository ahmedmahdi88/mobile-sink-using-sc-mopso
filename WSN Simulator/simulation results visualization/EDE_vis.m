f=figure;
ax=boxplot([[SC_EDE*0.01]',[MMO_EDE*0.01]',[MO_EDE*0.01]',[N2_EDE*0.01]'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('E2E Delay comparison boxplot within 10 random solutions');
xlabel('algorithms');
ylabel('measure value [sec]');
set(gca,'FontWeight','bold');