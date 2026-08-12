classdef MOPSO
    properties (SetAccess=private)
        numberOfComponents
        solutionStruct            % The structure of the solution
        popStruct                 % the structure of population
        pop                       % population
        newPop                    % population after movment
        rep                       % repository 
        varSize
        numberOfSolutions         % Number of individuals in the population
        numberOfIterations        % Number of generations
        lowerBounds               % Lower Bounds
        higherBounds              % Higher Bounds
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

    end
    methods
        function mopso = MOPSO(numberOfSolutions,numberOfIterations,lowerBounds,higherBounds,numberOfComponents,...
                c1,c2,mu,gamma,beta,alpha,nGrid,nRep,w,wdamp)
            mopso.popStruct = struct('Position',[],'Velocity',[],'Cost',[],'Best',[],'IsDominated',[],'GridIndex',[],'GridSubIndex',[]);

            mopso.numberOfComponents = numberOfComponents;
            mopso.numberOfSolutions = numberOfSolutions;
            mopso.numberOfIterations = numberOfIterations;
            mopso.lowerBounds = lowerBounds;
            mopso.higherBounds = higherBounds;
            mopso.varSize=[1,2];
            %mopso.paretoStruct = struct('paretoSet',[],'paretoFront',[],'numberOfSolutions',[]);
            %mopso.globalPareto = mopso.paretoStruct;
            %mopso.localPareto = repmat(mopso.paretoStruct,numberOfSolutions,1);
            %mopso.iterationPareto = mopso.paretoStruct;            
            mopso.c1 = c1;
            mopso.c2 = c2;
            mopso.nRep=nRep;            
            mopso.w=w;              
            mopso.wdamp=wdamp;         
            mopso.nGrid=nGrid;            
            mopso.alpha=alpha;          
            mopso.beta=beta;             
            mopso.gamma=gamma;            
            mopso.mu=mu;
        end
        mopso = RunAlgorithm(mopso,objfun);
    end
end