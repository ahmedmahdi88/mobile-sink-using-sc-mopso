function f= MobileSinkObjFun(pos,env)
robot=env.robot;
rndVoz=env.rndVoz;
sensors=env.sensors;
traveledDist=0;
EnergyConsumption=0;
d0=1.5;
k=1;
Eelec=1;
eFs=1;
eMp=1;
startPoint.x=robot.start.x;
startPoint.y=robot.start.y;
travelPoints=[startPoint.x startPoint.y];
% finding Shortest Path
xy=travelPoints;
for j=1:length(pos.x)
        xy=[xy;pos.x(j) pos.y(j)];
end

for i=1:length(pos.x)+1
for j=1:length(pos.x)+1
D(i,j)=equlidianDist(xy(i,:),xy(j,:));
if D(i,j)==0
    D(i,j)=inf;
end
end
end
notVisitedNodes=2:size(D,2);
currentNode=1;
count=1;
seq=currentNode;
while count<size(D,2)
    [m(currentNode),vn]= min(D(currentNode,notVisitedNodes));
    indd=vn;
    currentNode=notVisitedNodes(indd);
    notVisitedNodes(indd)=[];
    count=count+1;
    seq=[seq currentNode];
end
seq=[seq 1];
% end finding shortest path
for i=1:length(env.rndVoz)
env.rndVoz(i).x=[];
env.rndVoz(i).y=[];
end

for i=1:length(pos.x)
    env.rndVoz(i).x=pos.x(i);
    env.rndVoz(i).y=pos.y(i);
end
rndVoz=env.rndVoz;
for i=seq
    travelPoints=[travelPoints; [xy(i,1) ,xy(i,2)]];  
end
for i=1:length(travelPoints)-1
    tmpDist=equlidianDist(travelPoints(i,:),travelPoints(i+1,:));
    traveledDist=traveledDist+tmpDist;
end

tmpDist=equlidianDist(travelPoints(1,:),travelPoints(i+1,:));
traveledDist= traveledDist+tmpDist;

for i=1:length(sensors)
    xySensors=[sensors(i).x sensors(i).y];
    prevDist=inf;
    for j=1:length(pos.x)
        xyVoz=[rndVoz(j).x rndVoz(j).y];
    tmpDist=equlidianDist(xySensors(:,:),xyVoz(:,:));
    
    if tmpDist<prevDist
        prevDist=tmpDist;
        d(i,j)=tmpDist;
        sensors(i).rndVozPoint=j;
        sensors(i).d=prevDist;
    end
    end
end
for i=1:length(sensors)
  if sensors(i).d<=3
   if sensors(i).d<d0
       EnergyConsumption=EnergyConsumption+k*Eelec+k*eFs*sensors(i).d^2;
   else 
       EnergyConsumption=EnergyConsumption+k*Eelec+k*eFs*sensors(i).d^4;
   end
  end
end

f(1)=5*traveledDist+10*length(pos.x(pos.x~=-1));
f(2)=EnergyConsumption;

end

