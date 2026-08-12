function moga = CalculateCrowdingDistance(moga,front)
% Description: Calculate the 'crowding distance' used in the original NSGA-II.

idColumnInd = moga.numberOfObjectives+1;  % Column number of individual's id

for frontID = 1:length(front)
    
    indxOfIndsInCF = front{frontID};                                       % Indices of individuals in current front
    numOfIndsInCF = length(indxOfIndsInCF);                                % Number of individuals in current front
    objsValsOfIndsInCF = moga.solutionsObjectiveValues(indxOfIndsInCF,:);  % Individuals' objectives values in current front
    objsValsOfIndsInCF = [objsValsOfIndsInCF indxOfIndsInCF'];             % Objctive values are sorted with individual ID
    
    for m = 1:moga.numberOfObjectives
        
        objsValsOfIndsInCF = sortrows(objsValsOfIndsInCF,m);
        
        moga.solutionDistance(objsValsOfIndsInCF(1,idColumnInd)) = Inf;             % The first one
        moga.solutionDistance(objsValsOfIndsInCF(numOfIndsInCF,idColumnInd)) = Inf; % The last one
        
        minObj = objsValsOfIndsInCF(1,m);             % The maximum of objective m
        maxObj = objsValsOfIndsInCF(numOfIndsInCF,m); % The minimum of objective m
        
        for i = 2:numOfIndsInCF-1
            id = objsValsOfIndsInCF(i,idColumnInd);
            moga.solutionDistance(id) = moga.solutionDistance(id)+(objsValsOfIndsInCF(i+1,m)-objsValsOfIndsInCF(i-1,m))/(maxObj-minObj);
        end
    end
end

end