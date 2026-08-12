function damopso = GenerateInitialPopulation(damopso,ObjectiveFunction)
% Uniform generation

for i = 1:damopso.numberOfSolutions
    % Create new individual
    individual = damopso.lowerBounds+rand(1,damopso.numberOfComponents).*(damopso.higherBounds-damopso.lowerBounds);
    
    
    % Bounding limit
    individual = CheckBounds(damopso,individual);
    
    % Add to population
    damopso.pop(i).Position = individual;
    damopso.pop(i).Velocity = zeros(1,damopso.numberOfComponents);
    costValues = ObjectiveFunction(individual);
    damopso.pop(i).Cost = costValues;
    damopso.pop(i).Best.Position=individual;
    damopso.pop(i).Best.Cost=costValues;
    damopso.pop(i).GridIndex=[];
    damopso.pop(i).GridSubIndex=[];
    
end
% Determine Domination
damopso.pop=DetermineDomination(damopso.pop);
indx=zeros(1,damopso.numberOfSolutions);
for i =1:damopso.numberOfSolutions
    indx(i)=damopso.pop(i).IsDominated;
end
damopso.rep=damopso.pop(~ logical(indx));
Grid=CreateGrid(damopso.rep,damopso.nGrid,damopso.alpha);
for i=1:numel(damopso.rep)
    damopso.rep(i)=FindGridIndex(damopso.rep(i),Grid);
end
