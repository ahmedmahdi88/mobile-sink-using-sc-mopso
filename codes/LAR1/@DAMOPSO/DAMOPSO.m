classdef DAMOPSO
    properties (SetAccess=private)
        numberOfComponents
        solutionStruct            % The structure of the solution
        popStruct                 % the structure of population
        pop                       % population
        newPop                    % population after movment
        rep                       % repository 
        varSize
        numberOfObjectives
        numberOfSolutions         % Number of individuals in the population
        numberOfIterations        % Number of generations
        solutionsRank             % solution rank
        solutionDistance          % the crowding distance of solutions
        lowerBounds               % Lower Bounds
        higherBounds              % Higher Bounds
        maxVel                    % maximum velocity
        minVel                    % minimum velocity
        nRep            % Repository Size
        w              % Inertia Weight
        wdamp         % Intertia Weight Damping Rate
        c1               % Personal Learning Coefficient
        c2               % Global Learning Coefficient
        nGrid            % Number of Grids per Dimension
        alpha          % Inflation Rate in grid
        beta             % Leader Selection Pressure
        gamma            % Deletion Selection Pressure
        mu             % Mutation Rate
        sigam          %angluar sectore size

    end
    methods
        function damopso = DAMOPSO(numberOfSolutions,numberOfIterations,lowerBounds,higherBounds,minVel,maxVel,numberOfComponents,...
                numberOfObjectives,c1,c2,mu,sigam,gamma,beta,alpha,nGrid,nRep,w,wdamp)
            damopso.popStruct = struct('Position',[],'Velocity',[],'Cost',[],'Best',[],'IsDominated',[],'GridIndex',[],'GridSubIndex',[]);

            damopso.numberOfComponents = numberOfComponents;
            damopso.numberOfObjectives =numberOfObjectives;
            damopso.numberOfSolutions = numberOfSolutions;
            damopso.numberOfIterations = numberOfIterations;
            damopso.lowerBounds = lowerBounds;
            damopso.higherBounds = higherBounds;
            damopso.maxVel=maxVel*(higherBounds-lowerBounds);
            damopso.minVel=minVel*(higherBounds-lowerBounds);
            damopso.varSize=[1,2];
            %damopso.paretoStruct = struct('paretoSet',[],'paretoFront',[],'numberOfSolutions',[]);
            %damopso.globalPareto = damopso.paretoStruct;
            %damopso.localPareto = repmat(damopso.paretoStruct,numberOfSolutions,1);
            %damopso.iterationPareto = damopso.paretoStruct;            
            damopso.c1 = c1;
            damopso.c2 = c2;
            damopso.nRep=nRep;            
            damopso.w=w;              
            damopso.wdamp=wdamp;         
            damopso.nGrid=nGrid;            
            damopso.alpha=alpha;          
            damopso.beta=beta;             
            damopso.gamma=gamma;            
            damopso.mu=mu;
            damopso.sigam=sigam;
        end
        damopso = RunAlgorithm(damopso,objfun);
        damopso = ExtractNextPopulation(damopso);
    end
end