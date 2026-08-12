function [xNodes,yNodes,xNodesVel,yNodesVel]=PointsAndVelsGenerator(numberOfNodes,xLimit1,xLimit2,yLimit1,...
    yLimit2,desVel,delta)

randNum=ceil(4*rand);
switch randNum
    case 1
        xNodes=xLimit1+(0.5*xLimit2-xLimit1)*rand(1,numberOfNodes);
        yNodes=xLimit1+(yLimit2-yLimit1)*rand(1,numberOfNodes);
    case 2
        xNodes=xLimit1+(xLimit2-xLimit1)*rand(1,numberOfNodes);
        yNodes=xLimit1+(0.5*yLimit2-yLimit1)*rand(1,numberOfNodes);
    case 3
        xNodes=xLimit1+0.5*xLimit2+(0.5*xLimit2-xLimit1)*rand(1,numberOfNodes);
        yNodes=xLimit1+(yLimit2-yLimit1)*rand(1,numberOfNodes);
    case 4
        xNodes=xLimit1+(xLimit2-xLimit1)*rand(1,numberOfNodes);
        yNodes=xLimit1+0.5*yLimit2+(0.5*yLimit2-yLimit1)*rand(1,numberOfNodes);
end
%generate random velocities for each point
xNodesVel=(desVel-delta+2*delta*rand(1,numberOfNodes)).*sign(randn(1,numberOfNodes));
yNodesVel=(desVel-delta+2*delta*rand(1,numberOfNodes)).*sign(randn(1,numberOfNodes));
xNodesVel=(xNodesVel)/ConvertToTimeUnit(1);
yNodesVel=(yNodesVel)/ConvertToTimeUnit(1);

end