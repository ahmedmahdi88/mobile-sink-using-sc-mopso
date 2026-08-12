function moga = ExtractNextPopulation(moga)
% Description: Extract the best n individuals among 2*n individuals
global angleRangeRanks
% Initialization
moga.numberOfSolutions = moga.numberOfSolutions/2;
nextPopulation = zeros(moga.numberOfSolutions,moga.numberOfComponents);
nextPopulationObjsValues = zeros(moga.numberOfSolutions,moga.numberOfObjectives);
nextPopulationRanks = zeros(1,moga.numberOfSolutions);
nextPopulationDistances = zeros(1,moga.numberOfSolutions);

n = 0;                                    % Individuals number of next population
rank = 1;                                 % Current rank number
indices = find(moga.solutionsRank==rank); % Indices of individuals in the current front
numOfIndividuals = length(indices);       % Number of individuals in the current front

while n+numOfIndividuals<=moga.numberOfSolutions
    
    nextPopulation(n+1:n+numOfIndividuals,:) = moga.solutions(indices,:);
    nextPopulationObjsValues(n+1:n+numOfIndividuals,:) = moga.solutionsObjectiveValues(indices,:);
    nextPopulationRanks(n+1:n+numOfIndividuals) = moga.solutionsRank(indices);
    nextPopulationDistances(n+1:n+numOfIndividuals) = moga.solutionDistance(indices);
    
    if rank == 1
        moga.paretoFront = moga.solutionsObjectiveValues(indices,:);
    end
    
    n = n+numOfIndividuals;
    rank = rank+1;
    
    indices = find(moga.solutionsRank==rank);
    numOfIndividuals = length(indices);
end

if n<moga.numberOfSolutions
    
    [solutionsRanges] = ComputeSolutionsAngles(moga,moga.solutionsObjectiveValues(indices,:));
    
    counter = 0;
    requiredIndices = [];
    solutionDistance = moga.solutionDistance;
    while counter<moga.numberOfSolutions-n
        counter = counter+1;
        
        % Get the maximum ranks of range
        ind1 = find(angleRangeRanks(solutionsRanges) == max(angleRangeRanks(solutionsRanges)));
        tempIndices = indices(ind1);
        [~,ind2] = max(solutionDistance(tempIndices));
        requiredIndices = [requiredIndices;tempIndices(ind2)];
        solutionDistance(tempIndices(ind2)) = -inf;
        
        % Update the range rank
        angleRangeRanks(solutionsRanges(ind1(ind2))) =...
            angleRangeRanks(solutionsRanges(ind1(ind2)))+1;
    end
    
    nextPopulation(n+1:moga.numberOfSolutions,:) = moga.solutions(requiredIndices,:);
    nextPopulationObjsValues(n+1:moga.numberOfSolutions,:) = moga.solutionsObjectiveValues(requiredIndices,:);
    nextPopulationRanks(n+1:moga.numberOfSolutions) = moga.solutionsRank(requiredIndices);
    nextPopulationDistances(n+1:moga.numberOfSolutions) = moga.solutionDistance(requiredIndices);
end

if n == 0
    moga.paretoFront = nextPopulationObjsValues;
end

% Assigning
moga.solutions = nextPopulation;
moga.solutionsObjectiveValues = nextPopulationObjsValues;
moga.solutionsRank = nextPopulationRanks;
moga.solutionDistance = nextPopulationDistances;


end