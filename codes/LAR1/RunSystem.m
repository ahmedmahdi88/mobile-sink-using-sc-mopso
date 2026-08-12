
nodesIndex=find([nodes.nodeWorkState]);
for i=1:length(nodesIndex)
    randInd=ceil(rand*length(nodesIndex));
    randInd=nodesIndex(randInd);
    nodesIndex(nodesIndex==randInd)=[];
    % Update the coverage zone of the node
    nodes(randInd)=nodes(randInd).UpdateCoverageZone(nodes);

%     nodes(randInd)=nodes(randInd).UpdateNodePos();
    nodes(randInd)=nodes(randInd).GenerateDataPackets(nodes);
    nodes(randInd)=nodes(randInd).ProcessNodeBuffers();
    nodes=nodes(randInd).SendNodePackets(nodes);

end

% Update time
%env=env.PlotEnv(nodes);
timeCounter=timeCounter+1;
%pause(0.001);