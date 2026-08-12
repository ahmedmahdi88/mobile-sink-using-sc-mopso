function n = consumePower(n)
Eelec=1;
k=n.averageSizeOfPacket;
eFs=0.01;
eMp=0.018;
d0=n.coverageZoneRadius;
    if n.sendingDistanse < d0
    E= Eelec*k* + eFs*k*n.sendingDistanse^2;
    else
    E= Eelec*k + eMp*k*n.sendingDistanse^4; 
    end
    n.nodeEnergyConsumption = n.nodeEnergyConsumption + E;
    n.momentalEnergyConsumption = E;
    power=(E/1); % nj/sec
    power=(power*10^-9); % j/sec = watt
    n.battaryPower = n.battaryPower - power;
    
end
    
    


    