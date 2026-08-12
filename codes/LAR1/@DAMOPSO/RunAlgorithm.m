function [ damopso ] = RunAlgorithm( damopso,ObjectiveFunction )
global angleRangeRanks
angleRangeRanks = zeros(1,ceil(360/damopso.sigam)); 
h=waitbar(0,'DAMOPSO Progress')

%% intializatio
damopso = GenerateInitialPopulation(damopso,ObjectiveFunction);
%% damopso Main Loop

for it=1:damopso.numberOfIterations
    damopso.newPop=damopso.pop;
    for i=1:damopso.numberOfSolutions
        
        leader=SelectLeader(damopso.rep,damopso.beta);
          %% move Solution
         velocity =damopso.w*damopso.pop(i).Velocity+damopso.c1*rand*( damopso.pop(i).Best.Position- damopso.pop(i).Position)...
            +damopso.c2*rand*(leader.Position- damopso.pop(i).Position);
        damopso.pop(i).Velocity =sign(velocity).*max(min(abs(velocity),damopso.maxVel),damopso.minVel); % limiting velocity to velocity range
        
         damopso.newPop(i).Position =   max(min(damopso.pop(i).Position+damopso.pop(i).Velocity,damopso.higherBounds),damopso.lowerBounds); % limiting position to position range         
        
        damopso.newPop(i).Cost = ObjectiveFunction(damopso.newPop(i).Position);
        
        % Apply Mutation
        pm=(1-(it-1)/(damopso.numberOfIterations-1))^(1/damopso.mu);
        if rand<pm
            NewSol.Position=Mutate(damopso.newPop(i).Position,pm,damopso.lowerBounds,damopso.higherBounds);
            NewSol.Cost=ObjectiveFunction(NewSol.Position);
            if Dominates(NewSol,damopso.newPop(i))
                damopso.newPop(i).Position=NewSol.Position;
                damopso.newPop(i).Cost=NewSol.Cost;

            elseif Dominates(damopso.newPop(i),NewSol)
                % Do Nothing

            else
                if rand<0.5
                    damopso.newPop(i).Position=NewSol.Position;
                    damopso.newPop(i).Cost=NewSol.Cost;
                end
            end
        end
        
        if Dominates(damopso.newPop(i),damopso.newPop(i).Best)
            damopso.newPop(i).Best.Position=damopso.newPop(i).Position;
            damopso.newPop(i).Best.Cost=damopso.newPop(i).Cost;
            
        elseif Dominates(damopso.pop(i).Best,damopso.pop(i))
            % Do Nothing
            
        else
            if rand<0.5
                damopso.newPop(i).Best.Position=damopso.newPop(i).Position;
                damopso.newPop(i).Best.Cost=damopso.newPop(i).Cost;
            end
        end
        
    end
    damopso.pop = [damopso.pop damopso.newPop] ;  % mereg both modefied swarm and origenal swarm
    damopso.numberOfSolutions = 2*damopso.numberOfSolutions;
    dominationMatrix = CalculateDominationMatrix(damopso);
    dominationInfo = FindDominationInfo(damopso,dominationMatrix);
    [front,damopso] = FindRankedParetoFronts(damopso,dominationInfo);
    damopso = CalculateCrowdingDistance(damopso,front);
    damopso = ExtractNextPopulation(damopso);
    

   
    % Determine Domination of Nedamopso.w Resository Members
    damopso.rep=DetermineDomination(damopso.rep);
    
    % Keep only Non-Dminated Memebrs in the Repository
    damopso.rep=damopso.rep(~[damopso.rep.IsDominated]);
    
    % Update Grid
    Grid=CreateGrid(damopso.rep,damopso.nGrid,damopso.alpha);

    % Update Grid Indices
    for i=1:numel(damopso.rep)
        damopso.rep(i)=FindGridIndex(damopso.rep(i),Grid);
    end
    
    % Check if Repository is Full
    if numel(damopso.rep)>damopso.nRep
        
        Extra=numel(damopso.rep)-damopso.nRep;
        for e=1:Extra
            damopso.rep=DeleteOneRepMemebr(damopso.rep,damopso.gamma);
        end
        
    end
    
    % Plot Costs
% %    
% %     PlotCosts(damopso.pop,damopso.rep);
% %     pause(0.01);
% %     
    % Shodamopso.w Iteration Information
    disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(damopso.rep))]);
    
    % Damping Inertia Weight
    damopso.w=damopso.w*damopso.wdamp;
    waitbar(it/damopso.numberOfIterations)
end

end

