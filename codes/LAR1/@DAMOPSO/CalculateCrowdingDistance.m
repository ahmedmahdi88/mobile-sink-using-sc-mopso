function damopso = CalculateCrowdingDistance(damopso,front)
% Description: Calculate the 'crowding distance' used in the original NSGA-II.
damopso.solutionDistance = zeros(1,damopso.numberOfSolutions);

idColumnInd = damopso.numberOfObjectives+1;  % Column number of individual's id
Costs = reshape([damopso.pop.Cost],damopso.numberOfObjectives,[])';
for frontID = 1:length(front)
    
    indxOfIndsInCF = front{frontID};                                       % Indices of individuals in current front
    numOfIndsInCF = length(indxOfIndsInCF);                                % Number of individuals in current front
   objsValsOfIndsInCF = Costs(indxOfIndsInCF,:);  % Individuals' objectives values in current front

    objsValsOfIndsInCF = [objsValsOfIndsInCF indxOfIndsInCF'];             % Objctive values are sorted with individual ID
     
    for m = 1:damopso.numberOfObjectives
        
        objsValsOfIndsInCF = sortrows(objsValsOfIndsInCF,m);
        
        damopso.solutionDistance(objsValsOfIndsInCF(1,idColumnInd)) = Inf;             % The first one
        damopso.solutionDistance(objsValsOfIndsInCF(numOfIndsInCF,idColumnInd)) = Inf; % The last one
%         damopso.solutionDistance(objsValsOfIndsInCF(1,idColumnInd)) = damopso.solutionDistance(objsValsOfIndsInCF(1,idColumnInd))+ ((objsValsOfIndsInCF(2,m)-(objsValsOfIndsInCF(1,m))/(maxObj-minObj));             % The first one

        minObj = objsValsOfIndsInCF(1,m);             % The minimum of objective m
        maxObj = objsValsOfIndsInCF(numOfIndsInCF,m); % The maximum of objective m
        
        for i = 2:numOfIndsInCF-1
            id = objsValsOfIndsInCF(i,idColumnInd);
            damopso.solutionDistance(id) = damopso.solutionDistance(id)+(objsValsOfIndsInCF(i+1,m)-objsValsOfIndsInCF(i-1,m))/(maxObj-minObj);
 
          end
    end
end

end