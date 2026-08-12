function mopso = GenerateInitialPopulation(mopso,ObjectiveFunction)
% Uniform generation

for i = 1:mopso.numberOfSolutions
    % Create new individual
    individual = mopso.lowerBounds+rand(1,mopso.numberOfComponents).*(mopso.higherBounds-mopso.lowerBounds);
    
    
    % Bounding limit
    individual = CheckBounds(mopso,individual);
    
    % Add to population
    mopso.pop(i).Position = individual;
    mospo.pop(i).Velocity = zeros(1,mopso.numberOfComponents);
    costValues = ObjectiveFunction(individual);
    mopso.pop(i).Cost = costValues;
    mopso.pop(i).Best.Position=individual;
    mopso.pop(i).Best.Cost=costValues;
    mopso.pop(i).GridIndex=[];
    mopso.pop(i).GridSubIndex=[];
    
end
% Determine Domination
mopso.pop=DetermineDomination(mopso.pop);
indx=zeros(1,mopso.numberOfSolutions);
for i =1:mopso.numberOfSolutions
    indx(i)=mopso.pop(i).IsDominated;
end
mopso.rep=mopso.pop(~ logical(indx));
Grid=CreateGrid(mopso.rep,mopso.nGrid,mopso.alpha);
for i=1:numel(mopso.rep)
    mopso.rep(i)=FindGridIndex(mopso.rep(i),Grid);
end
