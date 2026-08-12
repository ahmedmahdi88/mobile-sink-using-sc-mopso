% Run Algorithm
numberOfComponents=1;
integerComponents = false(1,numberOfComponents);

numberOfSolutions = 50;
numberOfObjectives = 5;
numberOfIterations = 300;

fraction = 0.5;%2/numberOfComponents;
crossoverOption = [fraction 1.2];    % Crossover option [fraction,ratio]  "Intermediate crossover"
mutationOption = [fraction 0.1 0.5]; % Mutation option [fraction,scale,shrink] "Gaussian mutation"

nsga2 = NSGA2(numberOfComponents,integerComponents,numberOfSolutions,numberOfObjectives, ...
    numberOfIterations,lowerBounds,upperBounds,crossoverOption,mutationOption);
[paretoFront t] = RunAlgorithm(nsga2,ObjectiveFunction,minN,maxN,maxMS,nSensors,maxMK,cr,sr,rr,seed);

save ([path2 scenarioName ],'seed','ObjectiveFunction','paretoFront',.....
    'lowerBounds','upperBounds','t')
