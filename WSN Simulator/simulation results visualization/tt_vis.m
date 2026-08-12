f=figure;
ax=boxplot([[SC_travTime*0.01]',[MMO_travTime*0.01]',[MO_travTime*0.01]',[N2_travTime*0.01]'],...
    'Labels',{'HSC-MOPSO','m-MOPSO','MOPSO','NSGA-II'});
set(gca,'FontSize',16);
set(ax,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Travelling Time comparison boxplot within 30 random solutions');
xlabel('algorithms');
ylabel('measure value [sec]');
set(gca,'FontWeight','bold');