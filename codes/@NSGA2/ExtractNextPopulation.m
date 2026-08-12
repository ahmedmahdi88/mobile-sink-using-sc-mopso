function moga = ExtractNextPopulation(moga)
% Description: Extract the best n individuals among 2*n individuals

% Initialization
moga.numberOfSolutions = moga.numberOfSolutions/2;
% nextPopulation = zeros(moga.numberOfSolutions,moga.numberOfComponents);
nextPopulationObjsValues = zeros(moga.numberOfSolutions,moga.numberOfObjectives);
nextPopulationRanks = zeros(1,moga.numberOfSolutions);
nextPopulationDistances = zeros(1,moga.numberOfSolutions);

n = 0;                                    % Individuals number of next population
rank = 1;                                 % Current rank number
indices = find(moga.solutionsRank==rank); % Indices of individuals in the current front
numOfIndividuals = length(indices);       % Number of individuals in the current front

while n+numOfIndividuals<=moga.numberOfSolutions
    
    nextPopulation(n+1:n+numOfIndividuals) = moga.solutions(indices);
    nextPopulationObjsValues(n+1:n+numOfIndividuals,:) = moga.solutionsObjectiveValues(indices,:);
    nextPopulationRanks(n+1:n+numOfIndividuals) = moga.solutionsRank(indices);
    nextPopulationDistances(n+1:n+numOfIndividuals) = moga.solutionDistance(indices);
    
    n = n+numOfIndividuals;
    rank = rank+1;
    
    indices = find(moga.solutionsRank==rank);
    numOfIndividuals = length(indices);
end

if n<moga.numberOfSolutions
    % If the number of individuals in the next front plus the number of individuals
    % in the current front is greater than the population size, then select the
    % best individuals by corwding distance (NSGA-II).
    
    distance = moga.solutionDistance(indices)';
    distance = [distance indices'];
    distance = flipud(sortrows(distance,1));            % Sort the individuals in descending order of crowding distance in the front
    indices  = distance(1:moga.numberOfSolutions-n,2);  % Select the (popsize-n) individuals with largest crowding distance
    
    nextPopulation(n+1:moga.numberOfSolutions) = moga.solutions(indices);
    nextPopulationObjsValues(n+1:moga.numberOfSolutions,:) = moga.solutionsObjectiveValues(indices,:);
    nextPopulationRanks(n+1:moga.numberOfSolutions) = moga.solutionsRank(indices);
    nextPopulationDistances(n+1:moga.numberOfSolutions) = moga.solutionDistance(indices);
end

% Assigning
moga.solutions = nextPopulation;
moga.solutionsObjectiveValues = nextPopulationObjsValues;
moga.solutionsRank = nextPopulationRanks;
moga.solutionDistance = nextPopulationDistances;

end