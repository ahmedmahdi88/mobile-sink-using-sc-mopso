function dominationMatrix = CalculateDominationMatrix(moga)
% This function calculate the domination matrix which specifies 
% the domination releation between two individuals
%
% ind1: index of individual 1
% ind2: index of individual 2
%
% dominationMatrix(ind1,ind2) = 1  : individual 1 dominates individual 2
% dominationMatrix(ind1,ind2) = -1 : individual 2 dominates individual 1
% dominationMatrix(ind1,ind2) = 0  : non dominate

dominationMatrix  = zeros(moga.numberOfSolutions);

for ind1 = 1:moga.numberOfSolutions-1
    for ind2 = ind1+1:moga.numberOfSolutions
        
        individual1ObjsValues = moga.solutionsObjectiveValues(ind1,:);
        individual2ObjsValues = moga.solutionsObjectiveValues(ind2,:);
        
        if IsDominant(moga,individual1ObjsValues,individual2ObjsValues)
            dominationMatrix(ind1,ind2) = 1;
        elseif IsDominant(moga,individual2ObjsValues,individual1ObjsValues)
            dominationMatrix(ind1,ind2) = -1;
        end
    end
end

dominationMatrix = dominationMatrix-dominationMatrix';

end