function [ms]=move(ms,timeUnit)
global flags;
global timeCounter;
global momentOfStopping;
global savingTravTimeFlag;
global TravellingTime;
momentOfStopping(ms.Number)=-inf;
flags(ms.Number)=0;
numberOfRvps=length(ms.RVPs.x);
DistRvp=rem(ms.currentRVP,numberOfRvps)+1;
theta=...
    atan2d((ms.RVPs.y(DistRvp)-ms.RVPs.y(ms.currentRVP)),(ms.RVPs.x(DistRvp)-ms.RVPs.x(ms.currentRVP))...
    );
distance=ms.vel * 10^-2;%convertTimeUnitToSec(timeUnit); % convert from [m/s] to [m/timeUnit]
ms.x = ms.x + distance * cosd(theta);
ms.y = ms.y + distance * sind(theta);
msAmp=sqrt(ms.x^2+ms.y^2);
distRvpAmp=sqrt(ms.RVPs.x(DistRvp)^2+ms.RVPs.y(DistRvp)^2);
if msAmp==distRvpAmp
    flags(ms.Number)=1;
    momentOfStopping(ms.Number)= timeCounter;
end
%%%%%%%%%%
if (msAmp > (distRvpAmp-ms.vel*10^-2)) &&  (msAmp < (distRvpAmp+ms.vel*10^-2))
    ms.x=ms.RVPs.x(DistRvp);
    ms.y=ms.RVPs.y(DistRvp);
    ms.currentRVP=DistRvp;
    flags(ms.Number)=1;
    momentOfStopping(ms.Number)= timeCounter;
    if DistRvp==1 && savingTravTimeFlag(ms.Number)
    savingTravTimeFlag(ms.Number)=0;
    TravellingTime(ms.Number) = timeCounter;
    end
else
    % do no thing
end
end
%%%%%%%%%%
