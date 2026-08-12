function damopso = ExtractNextPopulation(damopso)
% Description: Extract the best n individuals among 2*n individuals
global angleRangeRanks
% Initialization
[solutionsRanges] = ComputeSolutionsAngles(damopso);
damopso.numberOfSolutions = damopso.numberOfSolutions/2;
nextPopulation = [];
nextPopulationRanks = zeros(1,damopso.numberOfSolutions);
nextPopulationDistances = zeros(1,damopso.numberOfSolutions);

n = 0;                                    % Individuals number of next population
rank = 1;                                 % Current rank number
indices = find(damopso.solutionsRank==rank); % Indices of individuals in the current front
numOfIndividuals = length(indices);       % Number of individuals in the current front

while n+numOfIndividuals<=damopso.numberOfSolutions
    
    nextPopulation=[nextPopulation damopso.pop(indices)];
    nextPopulationRanks(n+1:n+numOfIndividuals) = damopso.solutionsRank(indices);
    nextPopulationDistances(n+1:n+numOfIndividuals) = damopso.solutionDistance(indices);
    for i = 1: numel(indices)
        angleRangeRanks(solutionsRanges(indices(i)))= angleRangeRanks(solutionsRanges(indices(i)))+1;
    end
    if rank == 1
        damopso.rep = damopso.pop(indices);
    end
    
    n = n+numOfIndividuals;
    rank = rank+1;
    
    indices = find(damopso.solutionsRank==rank);
    numOfIndividuals = length(indices);
end

if n<damopso.numberOfSolutions

    indices = find(damopso.solutionsRank==rank); % Indices of individuals in the current front
    solutions = damopso.pop(indices);
    ranges = solutionsRanges(indices);
    aRanks=angleRangeRanks(ranges);
     [aRanks RI]=sort(aRanks);  % sort angle ranks in ascending order
    distances = damopso.solutionDistance(indices);
    %%distances(distances == inf)=-inf;
    [distances DI]=sort(distances,'descend'); % sort crowding Distance in descending ordwer
    counter = 0;
    requiredIndices = [];
   
    while counter<damopso.numberOfSolutions-n
        counter = counter+1;
        
       if rand <0.5
           requiredIndices=[requiredIndices indices(DI(1))];
           DI(1)=[];
       else
            requiredIndices=[requiredIndices indices(RI(1))];
           RI(1)=[];
       end
    end
     nextPopulation=[nextPopulation damopso.pop(requiredIndices)];
    nextPopulationRanks(n+1:damopso.numberOfSolutions) = damopso.solutionsRank(requiredIndices);
    nextPopulationDistances(n+1:damopso.numberOfSolutions) = damopso.solutionDistance(requiredIndices);
end



% Assigning
damopso.pop = nextPopulation;
damopso.solutionsRank = nextPopulationRanks;
damopso.solutionDistance = nextPopulationDistances;


end