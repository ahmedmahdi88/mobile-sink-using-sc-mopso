function [pop, numberOfClasses, classes,env]= ...
initialization(nSensors,popSize,nobj,minPos,maxPos,minN,maxN,maxMS,maxMK,cR,sr,rr)
% create the environment
distNodeClustThresh=cR;
env=initializeSink(nSensors);
%% extract x,y nodes
xNodes=[];
yNodes=[];
for i=1:2:nSensors*2
xNodes=[xNodes env.sensors(i)];
yNodes=[yNodes env.sensors(i+1)];
end
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
for m=1:MS
    pop(countPop).pos.RVP(m).x=xMK(idxx{m});
    pop(countPop).pos.RVP(m).y=yMK(idxx{m});
end
pop(countPop).cost=zeros(1,nobj);
pop(countPop).vel.CH.x=zeros(1,length(xCH));
pop(countPop).vel.CH.y=zeros(1,length(yCH));
for m=1:MS
    pop(countPop).vel.RVP(m).x=zeros(size(xMK(idxx{m})));
    pop(countPop).vel.RVP(m).y=zeros(size(yMK(idxx{m})));
end
pop(countPop).cont=0;
pop(countPop).IsDominated=false;
pop(countPop).pbest=pop(countPop).pos;
pop(countPop).GridIndex=[];
pop(countPop).GridSubIndex=[];
% pop(i).classVariables=[N,MS,MK];
classVars{countPop}=num2str([N,MS,MK]);
pop(countPop).classId=classVars{countPop};
end
UclassVars=unique(classVars);
numberOfClasses= length(UclassVars);
classes= UclassVars;
end


