function n=ConsumePower(n,packetSize,dist,distThresh,type)

% The model of power consumption is according to toutouh 2013
% n is a node
% packetSize is the packet size in bit
% type : determine if the transaction is send or receive

if type=='s'
    const=(440*5)/(6*10^6);
    if dist<=distThresh
    E=const*packetSize*dist^2;
    else
    E=const*packetSize*dist^4; 
    end
    
elseif type=='r'
    const=(260*5)/(6*10^6);
    if dist<=distThresh
    E=const*packetSize*dist^2;
    else
     E=const*packetSize*dist^4;
    end
end
n.nodeEnergyConsumption=n.nodeEnergyConsumption+E;

end