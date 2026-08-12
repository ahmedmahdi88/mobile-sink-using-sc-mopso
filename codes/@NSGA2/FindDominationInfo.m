function dominationInfo = FindDominationInfo(moga,dominationMatrix)
% This function find the domination information between the individuals
%
% dominationInfo.num: number of individuals which dominate this individual
% dominationInfo.set: set of individuals that this individual dominates

% ind1: index of individual 1
% ind2: index of individual 2

dominationInfo = repmat(struct('num',0,'set',[]),1,moga.numberOfSolutions);

for ind1 = 1:moga.numberOfSolutions-1
    for ind2 = ind1+1:moga.numberOfSolutions
        if dominationMatrix(ind1,ind2)==1       % Individual 1 dominates individual 2
            dominationInfo(ind2).num = dominationInfo(ind2).num+1;
            dominationInfo(ind1).set = [dominationInfo(ind1).set ind2];
        elseif dominationMatrix(ind1,ind2)==-1  % Individual 2 dominates individual 1
            dominationInfo(ind1).num = dominationInfo(ind1).num+1;
            dominationInfo(ind2).set = [dominationInfo(ind2).set ind1];
        end
    end
end

end