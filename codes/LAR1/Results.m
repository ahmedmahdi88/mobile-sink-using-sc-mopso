clc
close all

for i=30:10:150
load(['Experiment' num2str(i) '.mat']);
figure
plot((1:experSamples)*ConvertToTimeSec(rateOfLogging),PDR);
xlabel('Time [sec]');
ylabel('PDR');

figure
plot((1:experSamples)*ConvertToTimeSec(rateOfLogging),ConvertToTimeSec(E2EDelayAverage));
xlabel('Time [sec]');
ylabel('E2E delay [sec]');

figure
plot((1:experSamples)*ConvertToTimeSec(rateOfLogging),overhead);
xlabel('Time [sec]');
ylabel('Overhead');

figure
plot((1:experSamples)*ConvertToTimeSec(rateOfLogging),energyMean);
xlabel('Time [sec]');
ylabel('Mean of energy consumption');

figure
plot((1:experSamples)*ConvertToTimeSec(rateOfLogging),energyVariance);
xlabel('Time [sec]');
ylabel('Variance of energy consumption');

disp('Number of dropped packets due to packet life time')
numberOfDroppedPackets1
disp('Number of dropped packets due to data buffer overflow')
numberOfDroppedPackets2
disp('Number of dropped packets due to path break')
numberOfDroppedPackets3
end