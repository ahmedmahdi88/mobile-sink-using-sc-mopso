function [moga env] = GenerateInitialPopulation(moga,nSensors,minN,maxN,maxMS,maxMK,cR,sr,rr)
% Uniform generation
[pop, numberOfClasses, classes,env]= ...
NSGA2_AdHoc_Initialization(nSensors,moga.numberOfSolutions,moga.numberOfObjectives,moga.lowerBounds,moga.upperBounds,minN,maxN,maxMS,maxMK,cR,sr,rr);
 moga.solutions=pop;
% for i = 1:moga.numberOfSolutions
%     dim= round(unifrnd(lowerDim,higherDim));
%     individual.dim=dim;
%     % Create new individual
%     individual.pos = unifrnd( moga.lowerBounds(1),moga.upperBounds(1),lowerDim,dim);
%     individual.pos(dim+1:higherDim)=0;
% %     moga.lowerBounds+rand(1,moga.numberOfComponents).*(moga.upperBounds-moga.lowerBounds);
%     
%     % Rounding
%     individual.pos(moga.integerComponents) = round(individual.pos(moga.integerComponents));
%     
%     % Bounding limit
%     individual.pos = CheckBounds(moga,individual.pos);
%     
%     % Add to population
%     moga.solutions(i,:) = individual;
end