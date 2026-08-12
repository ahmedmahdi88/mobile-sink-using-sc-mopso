function [ mopso ] = RunAlgorithm( mopso,ObjectiveFunction )
h=waitbar(0,'MOPSO Progress')

%% intializatio
mopso = GenerateInitialPopulation(mopso,ObjectivepFunction);
%% MOPSO Main Loop
for it=1:mopso.numberOfIterations
    
    for i=1:mopso.numberOfSolutions
        
        leader=SelectLeader(mopso.rep,mopso.beta);
        
          %% move Solution
         mopso.pop(i).Position =   mopso.pop(i).Position+...
             mopso.c1*rand*( mopso.pop(i).Best.Position- mopso.pop(i).Position)...
            +mopso.c2*rand*(leader.Position- mopso.pop(i).Position);
        
        mopso.pop(i).Cost = ObjectiveFunction(mopso.pop(i).Position);
        
        % Apply Mutation
        pm=(1-(it-1)/(mopso.numberOfIterations-1))^(1/mopso.mu);
        if rand<pm
            NewSol.Position=Mutate(mopso.pop(i).Position,pm,mopso.lowerBounds,mopso.higherBounds);
            NewSol.Cost=ObjectiveFunction(NewSol.Position);
            if Dominates(NewSol,mopso.pop(i))
                mopso.pop(i).Position=NewSol.Position;
                mopso.pop(i).Cost=NewSol.Cost;

            elseif Dominates(mopso.pop(i),NewSol)
                % Do Nothing

            else
                if rand<0.5
                    mopso.pop(i).Position=NewSol.Position;
                    mopso.pop(i).Cost=NewSol.Cost;
                end
            end
        end
        
        if Dominates(mopso.pop(i),mopso.pop(i).Best)
            mopso.pop(i).Best.Position=mopso.pop(i).Position;
            mopso.pop(i).Best.Cost=mopso.pop(i).Cost;
            
        elseif Dominates(mopso.pop(i).Best,mopso.pop(i))
            % Do Nothing
            
        else
            if rand<0.5
                mopso.pop(i).Best.Position=mopso.pop(i).Position;
                mopso.pop(i).Best.Cost=mopso.pop(i).Cost;
            end
        end
        
    end
    
    % Add Non-Dominated Particles to REPOSITORY
    mopso.rep=[mopso.rep mopso.pop(~[mopso.pop.IsDominated])]; 
    
    % Determine Domination of Nemopso.w Resository Members
    mopso.rep=DetermineDomination(mopso.rep);
    
    % Keep only Non-Dminated Memebrs in the Repository
    mopso.rep=mopso.rep(~[mopso.rep.IsDominated]);
    
    % Update Grid
    Grid=CreateGrid(mopso.rep,mopso.nGrid,mopso.alpha);

    % Update Grid Indices
    for i=1:numel(mopso.rep)
        mopso.rep(i)=FindGridIndex(mopso.rep(i),Grid);
    end
    
    % Check if Repository is Full
    if numel(mopso.rep)>mopso.nRep
        
        Extra=numel(mopso.rep)-mopso.nRep;
        for e=1:Extra
            mopso.rep=DeleteOneRepMemebr(mopso.rep,mopso.gamma);
        end
        
    end
    
    % Plot Costs
% %    
% %     PlotCosts(mopso.pop,mopso.rep);
% %     pause(0.01);
% %     
    % Shomopso.w Iteration Information
    disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(mopso.rep))]);
    
    % Damping Inertia Weight
    mopso.w=mopso.w*mopso.wdamp;
    waitbar(it/mopso.numberOfIterations)
end

end

