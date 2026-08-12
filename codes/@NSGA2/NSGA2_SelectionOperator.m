function newPopulation = NSGA2_SelectionOperator(nsga2)
% Description: Selection operator, use binary tournament selection.

selIndices = zeros(1,nsga2.numberOfSolutions); % The indices of selected individuals
randNum = randi(nsga2.numberOfSolutions,[1,2*nsga2.numberOfSolutions]);

j = 1;
for i = 1:2:(2*nsga2.numberOfSolutions)
    
    individualInd1 = randNum(i);
    individualInd2 = randNum(i+1);
    
    % Crowded-comparison operator (NSGA-II)
    result = CrowdingComp(nsga2,individualInd1,individualInd2);
    
    if result==1
        selIndices(j) = individualInd1;
    else
        selIndices(j) = individualInd2;
    end
    j = j+1;
end

newPopulation = nsga2.solutions(selIndices);

end

function result = CrowdingComp(nsga2,ind1,ind2)
% Description: Crowding comparison operator.
% Return:
%   1 = individual with index ind1 is better than individual with index ind2
%   0 = other cases

if (nsga2.solutionsRank(ind1)<nsga2.solutionsRank(ind2)) || ...
        (nsga2.solutionsRank(ind1)==nsga2.solutionsRank(ind2) && ...
        nsga2.solutionDistance(ind1)>nsga2.solutionDistance(ind2))
    result = 1;
else
    result = 0;
end

end