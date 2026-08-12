function [moga,solutionsRanges,angleRangeRanks] = ComputeSolutionsAngles(moga,solutionsObjectiveValues)

solutionsAngles = atan2d(solutionsObjectiveValues(:,2),solutionsObjectiveValues(:,1));
solutionsAngles = solutionsAngles - min(solutionsAngles) + eps;
numberOfRanges = ceil(max(solutionsAngles)/moga.alpha);
numberOfRanges = min(numberOfRanges,size(solutionsAngles,1)) % in order to have at least one element in every section if the number of elements less than the number of sections 
sectElmNum = floor(size(solutionsAngles,1)/numberOfRanges);
sortedAngles = sort(solutionsAngles);
solutionsRanges = zeros(size(solutionsAngles,1),1);
for i =numberOfRanges:-1:1

    solutionsRanges(find(solutionsAngles<=sortedAngles(sectElmNum*i)))=i;

end
solutionsRanges(find(solutionsRanges == 0))= numberOfRanges;
%Alpha = optimizeAlfa(solutionsAngles,moga.alpha);
%[num edges]=histcounts(solutionsAngles,'Normalization','probability','BinMethod','fd');
%moga.alpha = edges(2)-edges(1);
% numberOfRanges = ceil(max(solutionsAngles)/moga.alpha);
% solutionsRanges = ceil(solutionsAngles/moga.alpha);

angleRangeRanks = zeros(1,numberOfRanges);
end