

clc
close all
Exp=[];
AvgPDR=[];
AvgE2EDelay=[];
AvgOverhead=[];
AvgEnergy=[];

for i=30:10:150
load(['Experiment' num2str(i) '.mat']);
Exp=[Exp i];
AvgPDR=[AvgPDR mean(PDR)];
AvgE2EDelay=[AvgE2EDelay mean(ConvertToTimeSec(E2EDelayAverage))];
AvgOverhead=[AvgOverhead mean(overhead)];
AvgEnergy=[AvgEnergy mean(energyMean)];

end

figure 
bar(Exp,AvgPDR)
title('PDR')
figure
ylabel('percentage')
xlabel('No of Vehicles')

bar(Exp,AvgE2EDelay)
title('E2E Delay')
xlabel('No of Vehicles')

figure
ylabel('Sec')
bar(Exp,AvgOverhead)
title('Overhead')
xlabel('No of Vehicles')

figure
bar(Exp,AvgEnergy)
title('Energy')
xlabel('No of Vehicles')

