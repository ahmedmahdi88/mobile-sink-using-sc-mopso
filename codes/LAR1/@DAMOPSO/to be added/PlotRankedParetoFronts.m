function PlotRankedParetoFronts(moga)

if moga.numberOfObjectives==2
    global colors
    figure(1);
    color = colors; 
   
    frontID = 1;        % Pareto front ID
    n = 0;
    while n<moga.numberOfSolutions
        individualsInds{frontID} = find(moga.solutionsRank==frontID);
        n = n+length(individualsInds{frontID});
        frontID = frontID+1;
    end
    
    for f = 1:length(individualsInds)
        plot(moga.solutionsObjectiveValues(individualsInds{f},1), ...
            moga.solutionsObjectiveValues(individualsInds{f},2),'*','Color',color(f,:));
        title(['Ranked Pareto Fronts / Iteration: ' num2str(moga.currentIteration)]); 
        xlabel('objective function 1'); ylabel('objective function 2');
        hold on;
        legends{f} = ['Pareto front rank: ' num2str(f)];
    end
    
    legend(legends);
    pause(0.000000001);
    hold off
end
end