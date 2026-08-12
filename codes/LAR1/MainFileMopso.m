clc
clear
close all
for seed=1:10
rng(seed);
global  timeExp numberOfNodes 
  timeExp =10;
  numberOfNodes =10;
%% Algorithm
% handle the objective function by its name
ObjectiveFunction = @EvalLAR;

numberOfComponents = 2;
lowerBounds = [10 1]; % coverageZoneRadius,timePeriodOfCovZonUpd
upperBounds = [1000 30];
numberOfSolutions = 20;
numberOfIterations = 50;
numberOfObjectives=3;
c1 = 1/3;
c2 = 2/3;
nRep=100;            % Repository Size
w=0.5;              % Inertia Weight
wdamp=0.99;         % Intertia Weight Damping Rate
nGrid=7;            % Number of Grids per Dimension
alpha=0.1;          % Inflation Rate in grid
beta=2;             % Leader Selection Pressure
gamma=2;            % Deletion Selection Pressure
mu=0.1;             % Mutation Rate
sigma =15;           %angular sector width [degrees]
maxVel=0.1;         % maximum relative velocity
minVel=0.001;       % minimum relative velocity 
mopso = MOPSO(numberOfSolutions,numberOfIterations,lowerBounds,upperBounds,numberOfComponents,...
                c1,c2,mu,gamma,beta,alpha,nGrid,nRep,w,wdamp);
         
mopso=RunAlgorithm(mopso,ObjectiveFunction);
save(['MOPSOL Results-' num2str(seed)])
end