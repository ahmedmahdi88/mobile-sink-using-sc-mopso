%% in this script, the system will run and as long as the system is running
% the nodes will communicate each other and the mobile sinks will move to
% one randi vous point
%% first looping within the working nodes and moving the mobileSinks simultaneously
%%%%% moving the mobile sinks

for m=1:nMS
    if timeCounter-momentOfStopping(m) > (ms(m).stoppingTime)
    [ms(m)] = ms(m).move(timeUnit);
    end
end

workNodeInds=find([nodes.nodeWorkState]);
% generating data puckets
%%%%%%%%%%
for i=workNodeInds
nodes(i)=nodes(i).generateDataPuckets();
end
%%%%%%%%% communication within nodes
for nd=workNodeInds;
    [nodes(nd) nodes]= nodes(nd).communication(nodes,rvpMob);
end
%%%%%%%%% delete dead puckets
for i=workNodeInds
nodes(i)=nodes(i).deleteDeadPuckets();
end
%%%%%%%% deleted dead nodes
for i=workNodeInds
nodes(i)=nodes(i).updateWorkState();
end
%%%%%%%%%%%%%%%%%%%%%
%%