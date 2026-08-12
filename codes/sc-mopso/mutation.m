function [mutatedParticle counterMut counter] = mutation(counterMut,counter,particle,mutationProbability,mutationRatio,env,covThreshold,sensorPos,LB,HB)
if rand < mutationProbability
    counterMut=counterMut+1;
numberOfMutatedVariables=1;%ceil(mutationRatio*length(particle.x));
randomIndicis=round(unifrnd(1,length(particle.x),1,numberOfMutatedVariables));
% mutatedParticle.x(randomIndicis)= unifrnd(
% mutatedParticle.y(randomIndicis)= particle.y(randomIndicis)+...
%     rand(1,numberOfMutatedVariables).*particle.y(randomIndicis);
%  cov=computeCov(mutatedParticle,env);
%  while cov<covThreshold
%      randomIndicis=round(unifrnd(1,length(particle.x),1,numberOfMutatedVariables));
% mutatedParticle.x(randomIndicis)= particle.x(randomIndicis)+...
%     rand(1,numberOfMutatedVariables).*particle.x(randomIndicis);
% mutatedParticle.y(randomIndicis)= particle.y(randomIndicis)+...
%     rand(1,numberOfMutatedVariables).*particle.y(randomIndicis);
%      cov=computeCov(mutatedParticle,env);
%  end
mutatedParticle=particle;
mutatedParticle.x(randomIndicis)=round(unifrnd(LB,HB,1,numberOfMutatedVariables),1);
mutatedParticle.y(randomIndicis)=round(unifrnd(LB,HB,1,numberOfMutatedVariables),1);
 cov=computeCov(mutatedParticle,env);
 c=0;
  while cov<covThreshold  
      c=c+1;
      if c>20
          counter=counter+1;
           mutatedParticle=particle;
           return;
      end
      rvp=mutatedParticle;
    [rvp,nonCoverdSensors] = computeAddedSensors(rvp,sensorPos,3)
SenInd=find(nonCoverdSensors==0);
senInd=SenInd(round(unifrnd(1,length(SenInd))));
[randomIndicis]=find(rvp.numberOfAddedSensors==min(rvp.numberOfAddedSensors));
randomIndicis=randomIndicis(round(unifrnd(1,length(randomIndicis))));
mutatedParticle.x(randomIndicis)=round(unifrnd(sensorPos.x(senInd)-0.5,sensorPos.x(senInd)+0.5,1,numberOfMutatedVariables),1);
mutatedParticle.y(randomIndicis)=round(unifrnd(sensorPos.y(senInd)-0.5,sensorPos.y(senInd)+0.5,1,numberOfMutatedVariables),1);
 cov=computeCov(mutatedParticle,env)

  end
else
    mutatedParticle=particle;
end
end
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