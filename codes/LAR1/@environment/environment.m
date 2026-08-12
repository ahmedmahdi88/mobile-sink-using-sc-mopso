classdef environment
    
    properties (SetAccess=private)
        background;
        delta=2.5;
        numberOfNodes;            % Number of mobile node
        timePeriodOfPlotUpd;
    end

    methods
        function e=environment(numberOfNodes)
            e.background=imread('grass.jpg');
            e.background=imresize(e.background,[300 300]);
            e.numberOfNodes=numberOfNodes;
            e.timePeriodOfPlotUpd=20;
        end
        env=PlotEnv(env,nodes);
    end
end