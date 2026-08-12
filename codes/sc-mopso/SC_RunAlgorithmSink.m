function [countNotValid,countMoved,countMut,countMutRef,cccc,countIsFixed,pop...
    ,env,enhancement_timeout,paretoFront,paretoSet ,NC, classes]=...
    RunAlgorithm(RepSize,nGrid,alpha,nSensors,scenario,objfun,popSize...
    ,nobj,lowerBound_pos,heigherBound_pos,numberOfIter,...
    w,mutationProbability,mutationRatio,minN,maxN,maxMS,maxMK,...
    cR,sr,rr,Vmin,Vmax)
%% initialization
% population initialization
countNotValid=0;
countMoved=0;
[pop,NC,classes,env]= initializationSink(nSensors,popSize,nobj,lowerBound_pos,heigherBound_pos,minN,maxN,maxMS,maxMK,cR,sr,rr);
%% evaluation
% calculate particles cost
for i=1:popSize
    pop(i).cost= objfun(pop(i).pos,env);
end
%% counting number of classes
classNum=1:length(classes);
%% determine non dominated solutions
pop=DetermineDomination(pop);
Rep=[];
%% starting main sc-mopso algorithm
% initialize AMC Matrices
for j=1:NC
    str= ['AMC' num2str(classNum(j))]; % AMC matrix for each class
    eval([str '=[]']);
end
for j=1:NC
    str=['AMC' num2str(classNum(j))];
    tmp=eval(str);
    for i=1:numel(pop)
        if isequal(pop(i).classId,(classes{j}))
            tmp=[tmp pop(i)];
        end
    end
    eval([str '=tmp']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize RAM matrix
for j=1:NC
    str1=['AMC' num2str(classNum(j))];
    tmp1= eval(str1);
    costs=[];
    for i=1:numel(tmp1)
        costs=[costs; tmp1(i).cost];
    end
    str2=['ind' num2str(classNum(j))];
    str3=['min' num2str(classNum(j))];
    s=['[' str3  ']' '=min(transpose(costs),[],2)'];
    eval(s);
end
RAM=zeros(nobj,NC);
for i=1:NC
    RAM(:,i)=eval(['min' num2str(classNum(i))]); %% RAM matrix for all population
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% settinf some temporary parameters
enhancement_timeout=5;
countIsFixed=0;
hhhh = waitbar(1,'hello');
cccc=0;
countMutRef=0;
countMut=0;
f=5;
%% start iterations
% start iterations ..................................................

for iter=1:numberOfIter
    deletedClasses=[];
    tic
    clc
    prog=['Senario: ' num2str(scenario) ' from 10 scenarios | '  'iter:' num2str(iter) ' progress: ' num2str(ceil(100-(numberOfIter-iter)/numberOfIter*100)) '%'];
    waitbar(1-((numberOfIter-iter)/numberOfIter),hhhh,prog)
    %**************************************************************
    %% determine nonDominated sols
    pop=DetermineDomination(pop);
    %% update the repository
    for i=1:popSize
        if ~pop(i).IsDominated
            Rep= [Rep pop(i)];
        end
    end
    Rep=DetermineDomination(Rep);
    ind=false(1,numel(Rep));
    for i=1:numel(Rep)
        if Rep(i).IsDominated
            ind(i)=true;
        end
    end
    Rep(ind)=[];
    Grid=CreateGrid(Rep,nGrid,alpha);
    
    for i=1:numel(Rep)
        Rep(i)=FindGridIndex(Rep(i),Grid);
    end
    gi=zeros(1,numel(Rep));
    for i=1:numel(Rep)
        gi(i)=Rep(i).GridIndex;
    end
    uniq=(unique(gi));
    while numel(Rep)>RepSize
        Rep=deleteFromRep(uniq,Rep);
    end
    %*************************************************************
    % disp(['iter=' num2str(iter)])
    %% update AMC matrices
    for c=classNum % start AMC loop
        str = ['AMC' num2str(c)];
        tmpAMC=eval(str);
        costs=[];
        for i=1:numel(tmpAMC)
            costs=[costs; tmpAMC(i).cost];
        end
        costs=costs';
        if(isempty(costs)) % if AMS is empty then continue
            continue;
        end
        %%
        f=nobj+1-f; % select objectives alternately
        %         f=round(unifrnd(1,nobj)); % determine random objective
        %% create pdf for each AMC
        if all(costs(f,:)==0)     % if all objectives values =0 then the selection
            % probability is the same for all
            pdfpf=ones(size(costs(f,:)))/length(costs(f,:));
        else
            pdfpf=costs(f,:)/sum(costs(f,:)); % calculate pdf
        end
        %% select an examplar for this class
        h=RouletteWheelSelectionMin((pdfpf)); % select random exampler
        disp(['h=' num2str(h)]);
        if isempty(h)
            h=1;
        end
        %      figure
        %      plot(pdfpf);
        %% reset the count at the end of moving window
        for i=1:length(tmpAMC)
            if mod(iter,round(numberOfIter/10))==0
                tmpAMC(i).cont=0;
                %            caa=0;
            end
            %% determine each 2 corresponding metamerics
            [ind1,ind2]= Reconciliation(tmpAMC(i).pbest,tmpAMC(i).pos);
            [ind3,ind4]= Reconciliation(tmpAMC(h).pos,tmpAMC(i).pos);
            %% clusters Reconciliation
            indch1=ind1.CH;
            indch2=ind2.CH;
            indch3=ind3.CH;
            indch4=ind4.CH;
            %% RVPs Reconciliation
            for m=1:numel(tmpAMC(i).pos.RVP)
                indRvp1{m}=ind1.RVP(m).val;
                indRvp2{m}=ind2.RVP(m).val;
            end
            %%%%%
            for m=1:numel(tmpAMC(i).pos.RVP)
                indRvp3{m}=ind3.RVP(m).val;
                indRvp4{m}=ind4.RVP(m).val;
            end
            tmp=tmpAMC(i);
            %% clusters local movement
            tmp.vel.CH.x(indch2)= w*tmp.vel.CH.x(indch2)+ 2*rand(1,length(indch2)).*(tmp.pbest.CH.x(indch1)-tmp.pos.CH.x(indch2)) ;
            
            tmp.vel.CH.y(indch2)= w*tmp.vel.CH.y(indch2)+ 2*rand(1,length(indch2)).*(tmp.pbest.CH.y(indch1)-tmp.pos.CH.y(indch2)) ;
            
            %% RVPs local movement
            for m=1:numel(tmpAMC(i).pos.RVP)
                tmp.vel.RVP(m).x(indRvp2{m})= w*tmp.vel.RVP(m).x(indRvp2{m})+ 2*rand(1,length(indRvp2{m})).*(tmp.pbest.RVP(m).x(indRvp1{m})-tmp.pos.RVP(m).x(indRvp2{m})) ;
                tmp.vel.RVP(m).y(indRvp2{m})= w*tmp.vel.RVP(m).y(indRvp2{m})+ 2*rand(1,length(indRvp2{m})).*(tmp.pbest.RVP(m).y(indRvp1{m})-tmp.pos.RVP(m).y(indRvp2{m})) ;
                
            end
            %%%%%
            %% clusters global movement
            tmp.vel.CH.x(indch4)= w*tmp.vel.CH.x(indch4)+ 2*rand(1,length(indch4)).*(tmpAMC(h).pos.CH.x(indch3)-tmpAMC(i).pos.CH.x(indch4)) ;
            tmp.vel.CH.x(tmp.vel.CH.x<Vmin)=Vmin;
            tmp.vel.CH.x(tmp.vel.CH.x>Vmax)=Vmax;
            tmp.vel.CH.y(indch4)= w*tmp.vel.CH.y(indch4)+ 2*rand(1,length(indch4)).*(tmpAMC(h).pos.CH.y(indch3)-tmpAMC(i).pos.CH.y(indch4)) ;
            tmp.vel.CH.y(tmp.vel.CH.y<Vmin)=Vmin;
            tmp.vel.CH.y(tmp.vel.CH.y>Vmax)=Vmax;
            %% RVPs global movement
            for m=1:numel(tmpAMC(i).pos.RVP)
                tmp.vel.RVP(m).x(indRvp4{m})= w*tmp.vel.RVP(m).x(indRvp4{m})+ 2*rand(1,length(indRvp4{m})).*(tmpAMC(h).pos.RVP(m).x(indRvp3{m})-tmpAMC(i).pos.RVP(m).x(indRvp4{m})) ;
                tmp.vel.RVP(m).x(tmp.vel.RVP(m).x<Vmin)=Vmin;
                tmp.vel.RVP(m).x(tmp.vel.RVP(m).x>Vmax)=Vmax;
                tmp.vel.RVP(m).y(indRvp4{m})= w*tmp.vel.RVP(m).y(indRvp4{m})+ 2*rand(1,length(indRvp4{m})).*(tmpAMC(h).pos.RVP(m).y(indRvp3{m})-tmpAMC(i).pos.RVP(m).y(indRvp4{m})) ;
                tmp.vel.RVP(m).y(tmp.vel.RVP(m).y<Vmin)=Vmin;
                tmp.vel.RVP(m).y(tmp.vel.RVP(m).y>Vmax)=Vmax;
            end
            %% make the resulted moved particle as temporar particle
%             tmp=tmpAMC(i).pos;
            tmp.pos.CH.x = (tmpAMC(i).pos.CH.x + tmp.vel.CH.x);
            tmp.pos.CH.y = (tmpAMC(i).pos.CH.y + tmp.vel.CH.y);
            for m=1:numel(tmp.pos.RVP)
                tmp.pos.RVP(m).x= (tmp.pos.RVP(m).x + tmp.vel.RVP(m).x);
                tmp.pos.RVP(m).y= (tmp.pos.RVP(m).y + tmp.vel.RVP(m).y);
            end
            %% fixing this particle
            %% cheack coordinates Bounds
            tmp.pos=checkXYBounds(tmp.pos,lowerBound_pos,heigherBound_pos);
            %%  rounding clusters coordinates to the closest sensors
            % extracting sensors coordinates
            sensors=env.sensors;
            xSen=sensors(1:2:end);
            ySen=sensors(2:2:end);
            % computing sensors amplitudes
            ambSen=(xSen+ySen).^2;
            % extract cluster heads amplitudes
            Xcl=tmp.pos.CH.x;
            Ycl=tmp.pos.CH.y;
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
                tmp.pos.CH.x(cl)  =xSen(senInd(cl)) ;
                tmp.pos.CH.y(cl)=ySen(senInd(cl));
                adAmp(:,senInd(cl))=inf;
            end
            %% check constraints 
            valid=1;
            valid=checkConstraints(tmp.pos,sr,cR,xSen,ySen);
            %% evaluate the resulted temporar particle
            tmp_cost= objfun(tmp.pos,env);
            %% check if the resulted moved particle is better than old particle
            if valid
            if(Dominates(tmp_cost,tmpAMC(i).cost)) 
                tmpAMC(i)=tmp; % update particle position
            else
                % count number of non enhancement times for the particle
                tmpAMC(i).cont= tmpAMC(i).cont+1;
            end
            else
                countNotValid=countNotValid+1;
                tmpAMC(i)=tmpAMC(i);
            end
            
            %% update particle cost in AMC matrix
            tmpAMC(i).cost=objfun(tmpAMC(i).pos,env); % update particle cost
            %% update local best for this particle
            if Dominates( tmpAMC(i).cost, objfun(tmpAMC(i).pbest,env))
                tmpAMC(i).pbest= tmpAMC(i).pos; %update particle pbest
            end
        end % end particles in the same class loop
        eval([str '=tmpAMC' ]); %update AMC matrix for the current class
    end % end All classes AMCs loop
    
    %% update particles classes
    
    for j=classNum % for each class
        if NC==1 % if there is one class then break
            index=[];
            break;
        end
        index=[];
        str1=['AMC' num2str((j))];
        tmp1= eval(str1);
        %% Computing enhancementTimeOut for this class
        Cont=[];
        for ii=1:length(tmp1)
            Cont=[Cont tmp1(ii).cont]; % put all particle counts in 'Cont' vector
        end
        med=median(Cont); % compute the median of counts
        maxEnhancementTimeOut=(numberOfIter/10)-1;
        enhancement_timeout=maxEnhancementTimeOut*((maxEnhancementTimeOut-...
            med)/maxEnhancementTimeOut);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% loop over class particles
        for i=1:length(tmp1)
            if tmp1(i).cont>5 && length(tmp1)>0 % if the particle isn't improved within...
                %enhancement_timeout
                countMoved=countMoved+1;
                tmp1(i).cont=0; % reset the count
                newClassTemp=tmp1(i); % put the particle in temporar variable
                cf=round(unifrnd(1,nobj)); % random objective
                % create pdf for classe ojectives
                if all(RAM(cf,:)==0) % if all RAM objectives ==0 then select...
                    % with the same probability
                    pdfcf=ones(size( RAM(cf,:)))/length(RAM(cf,:));
                else
                    pdfcf=RAM(cf,:)/sum(RAM(cf,:));% pdf
                end
                % select the best class
                newClass=RouletteWheelSelectionMin(pdfcf);
               
                co=0;
                flag=0;
                CFlag=0;
                while classNum(newClass)==j || ismember(classNum(newClass),deletedClasses)  % ensure that the particle will not move...
                    % to the same class or to a lower length class
                    newClass=RouletteWheelSelectionMin(pdfcf);
                    if NC==1
                        CFlag=1;
                        break;
                    end
                    if isempty(newClass)
                        flag=1;
                        break;
                    end
                    co=co+1;
                    if co>50 % if we can't find new class
                        % leave the class in the same class
                        flag=1;
                        break;
                    end
                end
                if flag
                    continue;
                end
                if CFlag
                    break;
                end
                if isempty(newClass)
                    continue;
                end
                index=[index i];% put moved particle index in the "index" array to delete it
                str=['AMC' num2str(classNum(newClass))]; % get the new class AMC
                tmpNewACM=eval(str);
                ExampleNewClassParticle=tmpNewACM(1);
                % check the old and new particles formats
                classVarsNew=str2num(ExampleNewClassParticle.classId);
                
                classVarsOld=str2num(tmp1(i).classId);
                % move to new class procedure
                newClassTemp=MoveToAnotherClass(classVarsNew,classVarsOld,tmp1(i),newClassTemp,sensors,xSen,ySen,lowerBound_pos,heigherBound_pos);
                % evalute the resulted particle
                newClassTemp.cost=objfun(newClassTemp.pos,env);
                % update the AMC for the new class
                tmpNewACM=[tmpNewACM newClassTemp];
                eval([str '=tmpNewACM']);
            end % end if
        end % end particles in the same class loop
        tmp1(index)=[];
        
        eval([str1 '=tmp1']);% delete moved particles from AMC
    tmp1Val=eval(str1);
     if isempty(tmp1Val)
         deletedClasses=[deletedClasses j];
     end
    end % end classes loop
    %% delete moved particles from the class
    %% update classes and number of classes
    for j=classNum
        str1=['AMC' num2str((j))];
        tmp1= eval(str1);
    if isempty(tmp1)
        eval(['clear ' str1]); 
    end
    end
    classNum(ismember(classNum,deletedClasses))=[];
    NC= length(classNum);
    %% update RAM matrix
    for j=classNum
        str1=['AMC' num2str((j))];
        tmp1= eval(str1);
        costs=[];
        for i=1:numel(tmp1)
            costs=[costs; tmp1(i).cost];
        end
        str2=['ind' num2str((j))];
        str3=['min' num2str((j))];
        s=['[' str3  ']' '=min(transpose(costs),[],2)'];
        eval(s);
    end % end classes loop
    RAM=zeros(nobj,NC);
    contRam=0;
    for i=classNum
        contRam=contRam+1;
        RAM(:,contRam)=eval(['min' num2str((i))]);
    end
    %%%%%%%%%%%%%%%%%%%
    popC=0;
 for i=classNum
    str1=['AMC' num2str(i)];
    v=eval(str1);  % all particles objectives
    for j=1:length(v)
        popC=popC+1;
    pop(popC)=v(j);
    end
 end
end % end iterations
%% find pareto front and particles objectives values
    
for i=1:popSize
    classes{i}=pop(i).classId;
end
classes=unique(classes);
NC=length(classes);
paretoFront=[];
paretoSet=[];
cSet=0;
%**************************************************************
pop=DetermineDomination(pop);
for i=1:popSize
    if ~pop(i).IsDominated
        Rep= [Rep pop(i)];
    end
end
Rep=DetermineDomination(Rep);
ind=false(1,numel(Rep));
for i=1:numel(Rep)
    if Rep(i).IsDominated
        ind(i)=true;
    end
end
Rep(ind)=[];
for i=1:numel(Rep)
    paretoFront=[paretoFront;Rep(i).cost];
    paretoSet{i}=Rep(i).pos;
end
paretoSet=paretoSet';
close(hhhh) ;
t=toc;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



