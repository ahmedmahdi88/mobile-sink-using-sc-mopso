function newPopulation = NSGA2_MutationOperator(nsga2,newPopulation,env)
% This function represents "Gaussian mutation"
% Note: All of the individuals would do mutation, but only "mutationFraction"
%       of design variables of an individual would changed.

% Mutation options
fraction = nsga2.mutationOption(1); % Mutation fraction of variables of an individual
scale = nsga2.mutationOption(2);    % This paramter should be large enough for interger variables to change from one to another.
shrink = nsga2.mutationOption(3);

for i = 1:nsga2.numberOfSolutions
    
    % Create children
    child = newPopulation(i);
    cid=child.classId;
    cid=str2num(cid);
    sc = scale-shrink*scale*nsga2.currentIteration/nsga2.numberOfIterations;
    sc = sc*(nsga2.upperBounds-nsga2.lowerBounds);
    % clusters mutation
    N=cid(1);
    crsFlag = rand(1,N)<fraction;
    randNum = randn(1,N); % Normaly distribution
    child.pos.CH.x(crsFlag) = child.pos.CH.x(crsFlag)+sc.*randNum(crsFlag);
    child.pos.CH.y(crsFlag) = child.pos.CH.y(crsFlag)+sc.*randNum(crsFlag);
    % RVP mutation
    rvpNums=cid(3:end);
    for m=1:cid(2)
        crsFlag = rand(1,rvpNums(m))<fraction;
        randNum = randn(1,rvpNums(m)); % Normaly distribution
        child.pos.RVP(m).x(crsFlag) = child.pos.RVP(m).x(crsFlag)+sc.*randNum(crsFlag);
        child.pos.RVP(m).y(crsFlag) = child.pos.RVP(m).y(crsFlag)+sc.*randNum(crsFlag);
    end
    % Rounding
   sensors=env.sensors;
    xSen=sensors(1:2:end);
    ySen=sensors(2:2:end);
    % computing sensors amplitudes
    ambSen=(xSen+ySen).^2;
    % extract cluster heads amplitudes
    Xcl=child.pos.CH.x(1:N);
    Ycl=child.pos.CH.y(1:N);
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
        child.pos.CH.x(cl)  =xSen(senInd(cl)) ;
        child.pos.CH.y(cl)=ySen(senInd(cl));
        adAmp(:,senInd(cl))=inf;
    end
    
    % Bounding limit
    child.pos =checkXYBounds(child.pos,nsga2.lowerBounds,nsga2.upperBounds);
    
    valid=1;
    valid=checkConstraints(child.pos,40,60,xSen,ySen);
    % Replace
    if valid
    newPopulation(i) = child;
    end
end