function [front,moga] = FindRankedParetoFronts(moga,dominationInfo)

% Find the pareto front with rank 1
frontID = 1;        % Pareto front ID
individualsInds = find([dominationInfo.num]==0);
moga.solutionsRank(individualsInds) = 1;
front{frontID} = individualsInds;

% Calculate pareto rank of each individuals
while ~isempty(front{frontID})
    individualsInds = [];
    for i = front{frontID}
        for j = dominationInfo(i).set
            dominationInfo(j).num = dominationInfo(j).num-1;
            if dominationInfo(j).num==0
                moga.solutionsRank(j) = frontID+1;
                individualsInds = [individualsInds j];
            end
        end
    end
    frontID = frontID+1;
    front{frontID} = individualsInds;
end

front(frontID) = []; % Delete the last empty front set

end