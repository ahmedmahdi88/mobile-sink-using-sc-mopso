function [solutionsRanges] = ComputeSolutionsAngles(damopso)
solutionsObjectiveValues=real(reshape([damopso.pop.Cost],damopso.numberOfObjectives,[]))';
solutionsAngles = atan2d(solutionsObjectiveValues(:,2),solutionsObjectiveValues(:,1));
solutionsAngles(solutionsAngles<0)= solutionsAngles(solutionsAngles<0)+360; % to change the nigative angles to the suitable positive values 
solutionsRanges = ceil(solutionsAngles/damopso.sigam);

end