function newClassTemp = MoveToAnotherClass(classVarsNew,classVarsOld,oldParticle,newClassTemp,sensors,xSen,ySen,lowerBound_pos,heigherBound_pos)
sr=40;
cR=60;
nNodes=length(xSen);
Nnew=classVarsNew(1);
Nold=classVarsOld(1);
valid=0;
if Nnew<Nold
    newClassTemp.pos.CH.x(Nnew+1:end)=[];
    newClassTemp.pos.CH.y(Nnew+1:end)=[];
    newClassTemp.pbest.CH.x(Nnew+1:end)=[];
    newClassTemp.pbest.CH.y(Nnew+1:end)=[];
    newClassTemp.vel.CH.x(Nnew+1:end)=[];
    newClassTemp.vel.CH.y(Nnew+1:end)=[];
    [valid nonCoveredNode closestClust ]=checkConstraints(newClassTemp.pos,sr,cR,xSen,ySen);
    c=0;
    while ~valid
         nodesIdxToMakeCHsAround=randi(nNodes,[1,Nnew]);
     while length(nodesIdxToMakeCHsAround)~=length(unique(nodesIdxToMakeCHsAround))
         nodesIdxToMakeCHsAround=randi(nNodes,[1,Nnew]);
     end
        newClassTemp.pos.CH.x=xSen(nodesIdxToMakeCHsAround);
        newClassTemp.pos.CH.y=ySen(nodesIdxToMakeCHsAround);
%         randIdx=closestClust(1);
%         if c>2
%         randIdx=randi(length(closestClust));
%         c=0;
%         end
%         newClassTemp.pos.CH.x(randIdx)=xSen(nonCoveredNode);
%         newClassTemp.pos.CH.y(randIdx)=ySen(nonCoveredNode);
        [valid nonCoveredNode closestClust]=checkConstraints(newClassTemp.pos,sr,cR,xSen,ySen);
        c=c+1;
    end
elseif Nnew>Nold
    randomSensorIndices=randi(length(sensors)/2,[1,Nnew-Nold]);
    while length(randomSensorIndices)~=length(unique(randomSensorIndices))
        randomSensorIndices=randi(length(sensors)/2,[1,Nnew-Nold]);
    end
    newClassTemp.pos.CH.x(Nold+1:Nnew)=xSen(randomSensorIndices);
    newClassTemp.pos.CH.y(Nold+1:Nnew)=ySen(randomSensorIndices);
    newClassTemp.pbest.CH.x(Nold+1:Nnew)=newClassTemp.pos.CH.x(Nold+1:Nnew);
    newClassTemp.pbest.CH.y(Nold+1:Nnew)=newClassTemp.pos.CH.y(Nold+1:Nnew);
    newClassTemp.vel.CH.x(Nold+1:Nnew)=zeros(1,Nnew-Nold);
    newClassTemp.vel.CH.y(Nold+1:Nnew)=zeros(1,Nnew-Nold);
else
    newClassTemp.pos.CH.x=oldParticle.pos.CH.x;
    newClassTemp.pos.CH.y=oldParticle.pos.CH.y;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
MSnew=classVarsNew(2);
MSold=classVarsOld(2);
contIdx=2;
if MSnew<MSold
    newClassTemp.pos.RVP(MSnew+1:end)=[];
    newClassTemp.pbest.RVP(MSnew+1:end)=[];
    newClassTemp.vel.RVP(MSnew+1:end)=[];
    for mms=1:MSnew
        rvpNumNew=classVarsNew(mms+contIdx);
        rvpNumOld=classVarsOld(mms+contIdx);
        if rvpNumNew<rvpNumOld
            newClassTemp.pos.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.pos.RVP(mms).y(rvpNumNew+1:end)=[];
            newClassTemp.vel.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.vel.RVP(mms).y(rvpNumNew+1:end)=[];
            newClassTemp.pbest.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.pbest.RVP(mms).y(rvpNumNew+1:end)=[];
        elseif rvpNumNew>rvpNumOld
            newClassTemp.pos.RVP(mms).x(rvpNumOld+1:rvpNumNew)=unifrnd(lowerBound_pos,heigherBound_pos,...
                1,rvpNumNew-rvpNumOld);
            newClassTemp.pos.RVP(mms).y(rvpNumOld+1:rvpNumNew)=unifrnd(lowerBound_pos,heigherBound_pos,...
                1,rvpNumNew-rvpNumOld);
            newClassTemp.vel.RVP(mms).x(rvpNumOld+1:rvpNumNew)=zeros(1,rvpNumNew-rvpNumOld);
            newClassTemp.vel.RVP(mms).y(rvpNumOld+1:rvpNumNew)=zeros(1,rvpNumNew-rvpNumOld);
            newClassTemp.pbest.RVP(mms).x(rvpNumOld+1:rvpNumNew)=newClassTemp.pos.RVP(mms).x(rvpNumOld+1:rvpNumNew);
            newClassTemp.pbest.RVP(mms).y(rvpNumOld+1:rvpNumNew)=newClassTemp.pos.RVP(mms).y(rvpNumOld+1:rvpNumNew);
        end
        %                     contIdx=contIdx+1;
    end
    
elseif  MSnew>MSold
    contIdx=2;
    for mms=1:MSold
        rvpNumNew=classVarsNew(mms+contIdx);
        rvpNumOld=classVarsOld(mms+contIdx);
        if rvpNumNew<rvpNumOld
            newClassTemp.pos.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.pos.RVP(mms).y(rvpNumNew+1:end)=[];
            newClassTemp.vel.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.vel.RVP(mms).y(rvpNumNew+1:end)=[];
            newClassTemp.pbest.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.pbest.RVP(mms).y(rvpNumNew+1:end)=[];
        elseif rvpNumNew>rvpNumOld
            newClassTemp.pos.RVP(mms).x(rvpNumOld+1:rvpNumNew)=unifrnd(lowerBound_pos,heigherBound_pos,...
                1,rvpNumNew-rvpNumOld);
            newClassTemp.pos.RVP(mms).y(rvpNumOld+1:rvpNumNew)=unifrnd(lowerBound_pos,heigherBound_pos,...
                1,rvpNumNew-rvpNumOld);
            newClassTemp.vel.RVP(mms).x(rvpNumOld+1:rvpNumNew)=zeros(1,rvpNumNew-rvpNumOld);
            newClassTemp.vel.RVP(mms).y(rvpNumOld+1:rvpNumNew)=zeros(1,rvpNumNew-rvpNumOld);
            newClassTemp.pbest.RVP(mms).x(rvpNumOld+1:rvpNumNew)=newClassTemp.pos.RVP(mms).x(rvpNumOld+1:rvpNumNew);
            newClassTemp.pbest.RVP(mms).y(rvpNumOld+1:rvpNumNew)=newClassTemp.pos.RVP(mms).y(rvpNumOld+1:rvpNumNew);
        end
        %                contIdx=contIdx+1;
    end
    contIdx=2;
    for mms=MSold+1:MSnew
        rvpNumNew=classVarsNew(mms+contIdx)
        newClassTemp.pos.RVP(mms).x=unifrnd(lowerBound_pos,heigherBound_pos,...
            1,rvpNumNew);
        newClassTemp.pos.RVP(mms).y=unifrnd(lowerBound_pos,heigherBound_pos,...
            1,rvpNumNew);
        newClassTemp.pbest.RVP(mms).x=newClassTemp.pos.RVP(mms).x;
        newClassTemp.pbest.RVP(mms).y= newClassTemp.pos.RVP(mms).y;
        newClassTemp.vel.RVP(mms).x=zeros(1,rvpNumNew);
        newClassTemp.vel.RVP(mms).y=zeros(1,rvpNumNew);
        %                contIdx=contIdx+1;
    end
elseif MSnew==MSold
    contIdx=2;
    for mms=1:MSold
        rvpNumNew=classVarsNew(mms+contIdx);
        rvpNumOld=classVarsOld(mms+contIdx);
        if rvpNumNew<rvpNumOld
            newClassTemp.pos.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.pos.RVP(mms).y(rvpNumNew+1:end)=[];
            newClassTemp.vel.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.vel.RVP(mms).y(rvpNumNew+1:end)=[];
            newClassTemp.pbest.RVP(mms).x(rvpNumNew+1:end)=[];
            newClassTemp.pbest.RVP(mms).y(rvpNumNew+1:end)=[];
        elseif rvpNumNew>rvpNumOld
            newClassTemp.pos.RVP(mms).x(rvpNumOld+1:rvpNumNew)=unifrnd(lowerBound_pos,heigherBound_pos,...
                1,rvpNumNew-rvpNumOld);
            newClassTemp.pos.RVP(mms).y(rvpNumOld+1:rvpNumNew)=unifrnd(lowerBound_pos,heigherBound_pos,...
                1,rvpNumNew-rvpNumOld);
            newClassTemp.vel.RVP(mms).x(rvpNumOld+1:rvpNumNew)=zeros(1,rvpNumNew-rvpNumOld);
            newClassTemp.vel.RVP(mms).y(rvpNumOld+1:rvpNumNew)=zeros(1,rvpNumNew-rvpNumOld);
            newClassTemp.pbest.RVP(mms).x(rvpNumOld+1:rvpNumNew)=newClassTemp.pos.RVP(mms).x(rvpNumOld+1:rvpNumNew);
            newClassTemp.pbest.RVP(mms).y(rvpNumOld+1:rvpNumNew)=newClassTemp.pos.RVP(mms).y(rvpNumOld+1:rvpNumNew);
        end
    end
end
newClassTemp.classId=num2str(classVarsNew);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check coverage constraint
xmk=[];
ymk=[];
xch=[];
ych=[];
sR=40;
rvpR=40;
xch=newClassTemp.pos.CH.x;
ych=newClassTemp.pos.CH.y;
for ijk=1:numel(newClassTemp.pos.RVP)
    xmk=[xmk newClassTemp.pos.RVP(ijk).x];
    ymk=[ymk newClassTemp.pos.RVP(ijk).y];
end
[cov,nonCovered]=computeCov(xmk,ymk,xch,ych,sR,rvpR);
thrsh=sR+rvpR;
 while cov<1
     randIdx=randi(length(nonCovered));
     d=zeros(size(xmk));
     pClus=[xch(randIdx) ych(randIdx)];
     for rv=1:length(d)
         pr=[xmk(rv) ymk(rv)];
         d(rv)=equlidianDist(pClus,pr);
     end
     [~,ii]=min(d);
     xmk(ii)=unifrnd(xch(nonCovered(randIdx))-thrsh,xch(nonCovered(randIdx))+thrsh);
     ymk(ii)=unifrnd(ych(nonCovered(randIdx))-thrsh,ych(nonCovered(randIdx))+thrsh);
     [cov,nonCovered]=computeCov(xmk,ymk,xch,ych,sR,rvpR);
 end
 %%%%%%%%%5
 ci=1;
 for m=1:numel(newClassTemp.pos.RVP)
     len=length(newClassTemp.pos.RVP(m).x);
     newClassTemp.pos.RVP(m).x=xmk(ci:ci+len-1);
     newClassTemp.pos.RVP(m).y=ymk(ci:ci+len-1);
     ci=ci+len;
 end
 newClassTemp.pbest= newClassTemp.pos;
end