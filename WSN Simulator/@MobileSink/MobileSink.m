classdef MobileSink
    properties (SetAccess=private)
        % general parameters
        Number; % mobile sink address
        coverageZoneRadius; % radius of a circle representing the coverage area
        % position parameters
        x;
        y;
        vel; % robot velocity
        stoppingTime;
        %%%%
        RVPs; % assosiated RVPs
        travellingTime; % travelling time 
        currentRVP;
    end
    methods
        function m=MobileSink(Number,x,y,vel,RVP)
            % general parameters
            m.Number=Number;
            m.coverageZoneRadius=40;
            m.x=x;
            m.y=y;
            m.vel=vel;
            m.stoppingTime=convertSecToTimeUnit(1);
            m.travellingTime=0;
            m.RVPs=RVP;
            m.currentRVP=1;
        end
    end
end
            