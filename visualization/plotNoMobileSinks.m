close all

loadData;
plot(n2.paretoFront.solutionsObjectiveValues(:,end),'r','LineWidth',2);
hold on
plot(mmo.paretoFront(:,end),'b','LineWidth',2);
plot(mo.paretoFront(:,end),'k','LineWidth',2);
plot(sc.paretoFront(:,end),'g','LineWidth',2);
legend('NSGA-II','mMOPSO','MOPSO','HSC-MOPSO')
ylabel('cost')
xlabel('solution')