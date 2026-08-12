classdef NSGA2
    
    properties (SetAccess = private)
        numberOfComponents;       % Number of components
        integerComponents;        % Vector of true/false; true:integer | false:real
        numberOfSolutions;        % Number of individuals in the population
        solutions;                % The population
        numberOfObjectives;       % Number of objectives
        solutionsObjectiveValues; % Cost values of the solutions
        numberOfIterations;       % Number of generations
        lowerBounds;              % Lower Bounds
        upperBounds;              % Higher Bounds
        solutionsRank;            % Solutions rank
        solutionDistance;         % Solutions distance
        crossoverOption;          % Crossover option [fraction,ratio]  "Intermediate crossover"
        mutationOption;           % Mutation option [fraction,scale,shrink] "Gaussian mutation"
        currentIteration;         % Number of current iteration
    end
    methods
        function nsga2 = NSGA2(numberOfComponents,integerComponents,numberOfSolutions,numberOfObjectives, ...
            numberOfIterations,lowerBounds,upperBounds,crossoverOption,mutationOption)
            
            nsga2.numberOfComponents = numberOfComponents;
            nsga2.integerComponents = integerComponents;
            nsga2.numberOfSolutions = numberOfSolutions;
            nsga2.solutions =struct('dim',0,'pos',0);%= zeros(numberOfSolutions,numberOfComponents);
            nsga2.numberOfObjectives = numberOfObjectives;
            nsga2.solutionsObjectiveValues = zeros(numberOfSolutions,numberOfObjectives);
            nsga2.numberOfIterations = numberOfIterations;
            nsga2.lowerBounds = lowerBounds;
            nsga2.upperBounds = upperBounds;
            nsga2.crossoverOption = crossoverOption;
            nsga2.mutationOption = mutationOption;
        end
%         [paretoFront t] = RunAlgorithm(nsga2,ObjectiveFunction,lowerDim,higherDim,scenario);
%         nsga2 = GenerateInitialPopulation(nsga2,lowerDim,higherDim);
        
        state = IsDominant(nsga2,solution1ObjValues,solution2ObjValues);
        nsga2 = FastNonDominatedSort(nsga2);
        dominationMatrix = CalculateDominationMatrix(nsga2);
        dominationInfo = FindDominationInfo(nsga2,dominationMatrix);
        [front,nsga2] = FindRankedParetoFronts(nsga2,dominationInfo);
        nsga2 = CalculateCrowdingDistance(nsga2,front);
        newPopulation = NSGA2_SelectionOperator(nsga2);
        newPopulation = NSGA2_CrossoverOperator(nsga2,newPopulation,env);
        newPopulation = NSGA2_MutationOperator(nsga2,newPopulation,env);
        nsga2 = ExtractNextPopulation(nsga2);
        individual = CheckBounds(nsga2,individual);
        PlotRankedParetoFronts(nsga2);
    end
end