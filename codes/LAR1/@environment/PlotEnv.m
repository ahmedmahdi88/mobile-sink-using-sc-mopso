function env=PlotEnv(env,nodes)
global timeCounter;
if mod(timeCounter,env.timePeriodOfPlotUpd)~=0
    return;
end
figure;

nodeNum=2;
ang=0:0.05:2*pi;
xPoints=nodes(nodeNum).coverageZoneRadius.*cos(ang)+nodes(nodeNum).xNode;
yPoints=nodes(nodeNum).coverageZoneRadius.*sin(ang)+nodes(nodeNum).yNode;
% imshow(env.background);

hold on
xNodes=[nodes.xNode];
yNodes=[nodes.yNode];
plot(xNodes,yNodes,'ro','markersize',12);
% plot(xPoints,yPoints,'k--');
% for i=1:length(nodes)
%     text(xNodes(i),yNodes(i),num2str(i)); 
% end
hold off

end