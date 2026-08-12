function moga = FastNonDominatedSort(moga)

% Initialization
moga.solutionsRank = zeros(1,moga.numberOfSolutions);
moga.solutionDistance = zeros(1,moga.numberOfSolutions);

% Calculate the domination matrix
dominationMatrix = CalculateDominationMatrix(moga);

% Find the domination information between the individuals
dominationInfo = FindDominationInfo(moga,dominationMatrix);

% Calculate pareto rank of each individuals
[front,moga] = FindRankedParetoFronts(moga,dominationInfo);

% Calculate the distance
moga = CalculateCrowdingDistance(moga,front);

end