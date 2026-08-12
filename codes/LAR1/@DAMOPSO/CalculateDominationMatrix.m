function dominationMatrix = CalculateDominationMatrix(damopso)
% This function calculate the domination matrix which specifies 
% the domination releation between two individuals
%
% ind1: index of individual 1
% ind2: index of individual 2
%
% dominationMatrix(ind1,ind2) = 1  : individual 1 dominates individual 2
% dominationMatrix(ind1,ind2) = -1 : individual 2 dominates individual 1
% dominationMatrix(ind1,ind2) = 0  : non dominate

dominationMatrix  = zeros(damopso.numberOfSolutions); % sort origenal and modefied swarms 

for ind1 = 1:damopso.numberOfSolutions-1
    for ind2 = ind1+1:damopso.numberOfSolutions
        
        individual1ObjsValues = damopso.pop(ind1).Cost(:);
        individual2ObjsValues = damopso.pop(ind2).Cost(:);
        
        if IsDominant(damopso,individual1ObjsValues,individual2ObjsValues)
            dominationMatrix(ind1,ind2) = 1;
        elseif IsDominant(damopso,individual2ObjsValues,individual1ObjsValues)
            dominationMatrix(ind1,ind2) = -1;
        end
    end
end

dominationMatrix = dominationMatrix-dominationMatrix';

end