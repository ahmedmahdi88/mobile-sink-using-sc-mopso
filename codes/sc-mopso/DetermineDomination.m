%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA121
% Project Title: Multi-Objective Particle Swarm Optimization (MOPSO)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function pop=DetermineDomination(pop)

    nPop=numel(pop);
 
    for i=1:nPop-1
        for j=i+1:nPop
            
            if Dominates(pop(i).cost,pop(j).cost)
               pop(j).IsDominated=true;
            end
            
            if Dominates(pop(j).cost,pop(i).cost)
               pop(i).IsDominated=true;
            end
            
        end
    end

end