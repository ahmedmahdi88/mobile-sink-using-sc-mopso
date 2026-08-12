function newPopulation = NSGA2_CrossoverOperator(nsga2,newPopulation,env)
% This function represents "Intermediate Crossover Operator"
% Note: All of the individuals would be do crossover, but only "crossoverFraction"
%       of design variables of an individual would changed.

% Crossover option
fraction = nsga2.crossoverOption(1);
ratio = nsga2.crossoverOption(2);

for i = 1:2:nsga2.numberOfSolutions    % Population size should be even number
    
    % Create children
    parent1 = newPopulation(i);
    parent2 = newPopulation(i+1);
    child1=parent1;
    child2=parent2;
    P1_CID = parent1.classId;
    P1_CID = str2num(P1_CID);
    P2_CID = parent2.classId;
    P2_CID = str2num(P2_CID);
    P1_CH_dim = P1_CID(1);
    P2_CH_dim = P2_CID(2);
    finalN=min(P1_CH_dim,P2_CH_dim);
    
    N_crsFlag = [rand(1,finalN)<fraction ] ;
    N_randNum = rand(1,finalN); % Uniformly distribution
    child1.pos.CH.x(1:finalN) = parent1.pos.CH.x(1:finalN)+N_crsFlag.*N_randNum.*ratio.*(parent2.pos.CH.x(1:finalN)-parent1.pos.CH.x(1:finalN));
    child1.pos.CH.y(1:finalN) = parent1.pos.CH.y(1:finalN)+N_crsFlag.*N_randNum.*ratio.*(parent2.pos.CH.y(1:finalN)-parent1.pos.CH.y(1:finalN));
    child2.pos.CH.x(1:finalN) = parent2.pos.CH.x(1:finalN)-N_crsFlag.*N_randNum.*ratio.*(parent2.pos.CH.x(1:finalN)-parent1.pos.CH.x(1:finalN));
    child2.pos.CH.y(1:finalN) = parent2.pos.CH.y(1:finalN)-N_crsFlag.*N_randNum.*ratio.*(parent2.pos.CH.y(1:finalN)-parent1.pos.CH.y(1:finalN));
    
    P1_MS=P1_CID(2);
    P2_MS=P2_CID(2);
    finalMS=min(P1_MS,P2_MS);
    P1r=P1_CID(3:2+finalMS);
    P2r=P2_CID(3:2+finalMS);
    finalR=min(P1r,P2r);
    for m=1:finalMS
        R_crsFlag = rand(1,finalR(m))<fraction;
        R_randNum = rand(1,finalR(m));
        child1.pos.RVP(m).x(1:finalR(m)) = parent1.pos.RVP(m).x(1:finalR(m))+R_crsFlag.*R_randNum.*ratio.*(parent2.pos.RVP(m).x(1:finalR(m))-parent1.pos.RVP(m).x(1:finalR(m)));
        child1.pos.RVP(m).y(1:finalR(m)) = parent1.pos.RVP(m).y(1:finalR(m))+R_crsFlag.*R_randNum.*ratio.*(parent2.pos.RVP(m).y(1:finalR(m))-parent1.pos.RVP(m).y(1:finalR(m)));
        child2.pos.RVP(m).x(1:finalR(m)) = parent2.pos.RVP(m).x(1:finalR(m))-R_crsFlag.*R_randNum.*ratio.*(parent2.pos.RVP(m).x(1:finalR(m))-parent1.pos.RVP(m).x(1:finalR(m)));
        child2.pos.RVP(m).y(1:finalR(m)) = parent2.pos.RVP(m).y(1:finalR(m))-R_crsFlag.*R_randNum.*ratio.*(parent2.pos.RVP(m).y(1:finalR(m))-parent1.pos.RVP(m).y(1:finalR(m)));
    end
    % rounding clusters to closest node
    % child1
    sensors=env.sensors;
    xSen=sensors(1:2:end);
    ySen=sensors(2:2:end);
    % computing sensors amplitudes
    ambSen=(xSen+ySen).^2;
    % extract cluster heads amplitudes
    Xcl=child1.pos.CH.x(1:finalN);
    Ycl=child1.pos.CH.y(1:finalN);
    ampC=(Xcl+Ycl).^2;
    % create adjancacy matrix between clusters and sensors
    for cl=1:length(ampC)
        for se=1:length(ambSen)
            adAmp(cl,se)=abs(ampC(cl)-ambSen(se));
        end
    end
    % select the closest sensor to each cluster
    for cl=1:length(ampC)
        [~,senInd(cl)]=min(adAmp(cl,:));
        child1.pos.CH.x(cl)  =xSen(senInd(cl)) ;
        child1.pos.CH.y(cl)=ySen(senInd(cl));
        adAmp(:,senInd(cl))=inf;
    end
    % child2
    sensors=env.sensors;
    xSen=sensors(1:2:end);
    ySen=sensors(2:2:end);
    % computing sensors amplitudes
    ambSen=(xSen+ySen).^2;
    % extract cluster heads amplitudes
    Xcl=child2.pos.CH.x(1:finalN);
    Ycl=child2.pos.CH.y(1:finalN);
    ampC=(Xcl+Ycl).^2;
    % create adjancacy matrix between clusters and sensors
    for cl=1:length(ampC)
        for se=1:length(ambSen)
            adAmp(cl,se)=abs(ampC(cl)-ambSen(se));
        end
    end
    % select the closest sensor to each cluster
    for cl=1:length(ampC)
        [~,senInd(cl)]=min(adAmp(cl,:));
        child2.pos.CH.x(cl)  =xSen(senInd(cl)) ;
        child2.pos.CH.y(cl)=ySen(senInd(cl));
        adAmp(:,senInd(cl))=inf;
    end
    
    % Bounding limit
    child1.pos =checkXYBounds(child1.pos,nsga2.lowerBounds,nsga2.upperBounds);
    child2.pos =checkXYBounds(child2.pos,nsga2.lowerBounds,nsga2.upperBounds);
    % check Constraints
        valid1=1;
        valid2=1;
        sr=40;
        cR=60;
        valid1=checkConstraints(child1.pos,sr,cR,xSen,ySen);
   valid2=checkConstraints(child2.pos,sr,cR,xSen,ySen);
    
    % Replace
    if valid1
    newPopulation(i) = child1;
    else
        newPopulation(i)=newPopulation(i);
    end
     if valid2
    newPopulation(i+1) = child2;
     else
         newPopulation(i+1) =newPopulation(i+1) ;
     end
end
end