classdef Pucket
    properties (SetAccess=private)
        LifeTime; % bucket life time
        momentOfGeneration % moment of generation
    end
    methods
        function p=Pucket(momentOfGeneration)
            p.momentOfGeneration=momentOfGeneration;
            p.LifeTime=convertSecToTimeUnit(5);
        end
    end
end
    
        