function [pop, numberOfClasses, classes,env]= ...
initialization(nSensors,popSize,nobj,minPos,maxPos,minN,maxN,maxMS,maxMK,cR,sr,rr)
% create the environment
distNodeClustThresh=cR;
env=initializeSink(nSensors);
%% extract x,y nodes
xNodes=env.sensors(:,1:2:end);
yNodes=env.sensors(:,2:2:end);
%% compute amplitude for each node and create nodes amplitude vector
ampNodes=sqrt((xNodes+yNodes).^2);
% sort the nodes
[ampNodes I]=sort(ampNodes);
nNodes=length(ampNodes);
%% create the particle
countPop=0;
while countPop<popSize
    Bool=1;countt=0;
    N=randi([minN maxN]);
    while Bool
      % number of clusters
     %% generate CH coordinates
     nodesIdxToMakeCHsAround=randi(nNodes,[1,N]);
     while length(nodesIdxToMakeCHsAround)~=length(unique(nodesIdxToMakeCHsAround))
         nodesIdxToMakeCHsAround=randi(nNodes,[1,N]);
     end
     while length(nodesIdxToMakeCHsAround)<N
         idx=randi(nNodes);
         nodesIdxToMakeCHsAround=[nodesIdxToMakeCHsAround idx];
     end
     while length(nodesIdxToMakeCHsAround)>N
         idx=randi(nNodes);
         nodesIdxToMakeCHsAround(idx)=[];
     end
     xCH= xNodes((nodesIdxToMakeCHsAround));   
     yCH= yNodes((nodesIdxToMakeCHsAround));
     xyCH=[];
     for it=1:length(xCH)
     xyCH=[xyCH, xCH(it) yCH(it)];
     end
     
     % check sensors coverage by clusters constraints
     nodesClustersAdjaMat=zeros(length(xNodes),length(xCH));
     % adjancacy matrix
     for nod=1:length(xNodes)
         p1=[xNodes(nod) yNodes(nod)];
         for clust=1:length(xCH)
             p2=[xCH(clust) yCH(clust)];
             nodesClustersAdjaMat(nod,clust)=equlidianDist(p1,p2);
         end
     end
     % find the closest cluster to each node
     shorDist=[];
     closestClust=[];
     for nod=1:length(xNodes)
     [shorDist(nod),closestClust(nod)]=min(nodesClustersAdjaMat(nod,:));
     end
     if any(shorDist>distNodeClustThresh)
         Bool=1;
         countt=countt+1;
         if countt>200
         N=N+1;
         N(N>maxN)=maxN;
         countt=0;
         end
     else
         Bool=0;
     end
    end
     %% generate number of mobile sinks
     
     MS=randi(N); 
     
     %% generate the number of rvps for each mobile sink
     MK=randi(maxMK,1,MS);
     %% particle length
     %% generate rvps positions
     thrsh=sr+rr; % to make the positition around the cluster head 
     randIdx=randi(N);
     nMK=sum(MK); % number of rvps
     xMK=zeros(1,nMK);
     yMK=zeros(1,nMK);
     assigned=0;
     assigned=[assigned zeros(1,nMK-1)];
     xMK(1)=unifrnd(xCH(randIdx)-thrsh,xCH(randIdx)+thrsh);
  
     yMK(1)=unifrnd(yCH(randIdx)-thrsh,yCH(randIdx)+thrsh);
     
     [cov,nonCovered]=computeCov(xMK,yMK,xCH,yCH,sr,rr);
     % create rvps around the nonCovered cluster heads
     count=0;
     flag=0;
     while cov<1 || any(assigned==0)
        if count>50
            flag=1;
            break;
        end
     for ii=1:nMK
         
       if cov<1
           randIdx=randi(length(nonCovered));
           xMK(ii)=unifrnd(xCH(nonCovered(randIdx))-thrsh,xCH(nonCovered(randIdx))+thrsh);
           yMK(ii)=unifrnd(yCH(nonCovered(randIdx))-thrsh,yCH(nonCovered(randIdx))+thrsh);
       else 
           xMK(ii)=unifrnd(minPos,maxPos);
           yMK(ii)=unifrnd(minPos,maxPos);
       end
       assigned(ii)=1;
       [cov,nonCovered]=computeCov(xMK,yMK,xCH,yCH,sr,rr);
     end
      count=count+1;
     end
     if flag
         flag=0;
         continue;
     end
     xMK<minPos
     xMK>maxPos
     yMK<minPos
     yMK>maxPos
     xMK(xMK<minPos)=minPos;
     xMK(xMK>maxPos)=maxPos; 
     yMK(yMK<minPos)=minPos;
     yMK(yMK>maxPos)=maxPos;
     %% generate MSs positions
     randIdx=randi(nMK,1,MS);
     while length(randIdx)~=length(unique(randIdx));
         randIdx=randi(nMK,1,MS);
     end
     xMS=[];
     yMS=[];
     for ms=1:MS
     xMS(ms)=xMK(randIdx(ms));
     yMS(ms)=yMK(randIdx(ms));
     end
     %% assigne each rvp to the suitable Mobile sink
    idxx=RVPassignement(xMS,yMS,xMK,yMK,MK);
%% final particle position format
% pos{i}=[N,xyCH,MS,MSandMK];
%% particle length
% dims(i)=length(pos{i});
%% final
countPop=countPop+1;
pop(countPop).pos.CH.x=xCH;
pop(countPop).pos.CH.y=yCH;
% adding adhoc dims
pop(countPop).pos.CH.x(N+1:maxN)=0;
pop(countPop).pos.CH.y(N+1:maxN)=0;
%%%%%%%%%%
for m=1:MS
    pop(countPop).pos.RVP(m).x=xMK(idxx{m});
    pop(countPop).pos.RVP(m).y=yMK(idxx{m});
    % adding adHoc members
    pop(countPop).pos.RVP(m).x(MK(m)+1:maxMK)=0;
    pop(countPop).pos.RVP(m).y(MK(m)+1:maxMK)=0;
end
pop(countPop).cost=zeros(1,nobj);

pop(countPop).IsDominated=false;
% pop(i).classVariables=[N,MS,MK];
classVars{countPop}=num2str([N,MS,MK]);
pop(countPop).classId=classVars{countPop};
end
UclassVars=unique(classVars);
% for i=1:popSize
%     for j=1:length(UclassVars)
%     if classVars{i}==UclassVars{i}
numberOfClasses= length(UclassVars);
classes= UclassVars;
%% divide the population to classes
% uniqueDims=unique(dims);
% NC=length(uniqueDims); % classes number
% pop=struct();
% pop.classes(NC)=struct();
% classesSizes=zeros(1,NC);
%% compute size of each class
% c=1;
% for i=uniqueDims
%     relatedPops{c}=[];
%    for j=1:popSize
%       if dims(j)==i
%           classesSizes(c)=classesSizes(c)+1;
%           relatedPops{c}=[relatedPops{c} j];
%       end
%    end
%    c=c+1;
% end
%% initialize position values for each class
% c=1;
% for i=uniqueDims
%     for j=1:classesSizes(c)  
%             pop.classes(c).pos(j,:)=pos{relatedPops{c}(j)};
%             pop.classes(c).vel(j,:)=zeros(1,i);
%             pop.classes(c).Pbest(j,:)=pop.classes(c).pos(j,:);
%     end
%       c=c+1;
% end
% classes =uniqueDims;
% numberOfClasses=NC;
%% population

end


