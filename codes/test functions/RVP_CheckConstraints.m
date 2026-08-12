function [rvp,isFixed]=RVP_CheckConstraints(rvp,sensorPos,covThreshold,DistThreShold,AddedSensorsThreshold,env,lowerBound_pos,heigherBound_pos)
isFixed=0;
cov=computeCov(rvp,env);
 while cov <covThreshold
     [rvp,nonCoveredSensors] = computeAddedSensors(rvp,sensorPos,DistThreShold);
rvpArr=[];
for i=1:length(rvp.x)
    rvpArr=[rvpArr rvp.numberOfAddedSensors(i)];
end
senArr=[];
for i=1:length(rvp.x)
    senArr=[senArr rvp.addedSensors(i).values];
    uniqSenArr=unique(senArr);
    [a,b]=hist(senArr,uniqSenArr);
end
[~,minR]=min(rvpArr);
[~,maxS]=max(a);
maxCoveredSensor=b(maxS)
rvpMaxSen=[];
for r=1:length(rvp.x)
    if any(ismember(rvp.addedSensors(r).values,maxCoveredSensor))
        rvpMaxSen=[rvpMaxSen r];
    end
end
rvp.x
rvp.y
maxCoveredSensor
rvp.addedSensors.values
rvpArr
minRR=rvpArr(rvpMaxSen(1));
minR=rvpMaxSen(1);
rvpArr
for i=1:length(rvp.x)
    if ismember(i,rvpMaxSen)
        if rvpArr(i)<minRR
            minRR=rvpArr(i);
            minR=i;
        end
    end
end
% select non covered sensor
nonCoveredSensor=0;
% while ismember(nonCoveredSensor,senArr) ||  nonCoveredSensor==0
%     nonCoveredSensor=randperm(length(sensorPos.x));
% end
minR

nonCoveredSensors=find(nonCoveredSensors==0);
minR=find(rvp.numberOfAddedSensors==0);
minn=min(length(minR),length(nonCoveredSensors));
if minn~=0
for m=1:minn
     rvp.x(minR(m))=unifrnd(sensorPos.x(nonCoveredSensors(m))-(DistThreShold/2),sensorPos.x(nonCoveredSensors(m))+(DistThreShold/2));
     rvp.y(minR(m))=unifrnd(sensorPos.y(nonCoveredSensors(m))-(DistThreShold/2),sensorPos.y(nonCoveredSensors(m))+(DistThreShold/2));
end
else
[~,minR]=min(rvp.numberOfAddedSensors);
m=1;
rvp.x(minR(m))=unifrnd(sensorPos.x(nonCoveredSensors(m))-(DistThreShold/2),sensorPos.x(nonCoveredSensors(m))+(DistThreShold/2));
rvp.y(minR(m))=unifrnd(sensorPos.y(nonCoveredSensors(m))-(DistThreShold/2),sensorPos.y(nonCoveredSensors(m))+(DistThreShold/2));
end    

     rvp=checkXYBounds(rvp,lowerBound_pos,heigherBound_pos);
     rvp=checkBoundsSink(rvp,env);    
     cov=computeCov(rvp,env);
     isFixed=1;
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
function [rvp,nonCoverdSensors] = computeAddedSensors(rvp,sensorPos,DistThreShold)
    rvp.numberOfAddedSensors=zeros(size(rvp.x));
    nonCoverdSensors=zeros(size(sensorPos.x));
for i=1:length(rvp.x)
    rvp.addedSensors(i).values=[];
    xr=rvp.x(i);
        yr=rvp.y(i);
        pr=[xr yr];
for s=1:length(sensorPos.x)  
        xs=sensorPos.x(s);
        ys=sensorPos.y(s);
        ps=[xs ys];
        if equlidianDist(pr,ps)<=DistThreShold
            rvp.addedSensors(i).values= [rvp.addedSensors(i).values s];
            rvp.numberOfAddedSensors(i)=rvp.numberOfAddedSensors(i)+1;
            nonCoverdSensors(s)=1;
        end
    end
 end
end