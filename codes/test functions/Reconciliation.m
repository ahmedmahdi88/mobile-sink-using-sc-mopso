function [iind1,iind2]= Reconciliation(particle1,particle2)
N1=length(particle1.CH.x);
% now mapping between the 2 particles cluster heads 

for i=1:N1
    p1=[particle1.CH.x(i) particle1.CH.y(i)];
   
    for j=1:N1
        p2=[particle2.CH.x(j)  particle2.CH.y(j)];
        adjaMatClusters(i,j)=equlidianDist(p1,p2);
      
    end
    
end
iind1.CH=1:N1;
for i=1:N1
    [~,iind2.CH(i)]=min(adjaMatClusters(i,:));
    adjaMatClusters(:,iind2.CH(i))=inf;
end
MS1=numel(particle1.RVP);
for m=1:MS1
adjaMatrix{m}=inf*ones(length(particle1.RVP(m).x));  % initialize adjacancy matrix
% compute adjacency matrix  
particle1.RVP(m).x
particle2.RVP(m).x
for p1=1:length(particle1.RVP(m).x)
    tmpPoint1=[particle1.RVP(m).x(p1) particle1.RVP(m).y(p1)];
    for p2=1:(length(particle1.RVP(m).x))
    tmpPoint2=[particle2.RVP(m).x(p2) particle2.RVP(m).y(p2)];
    adjaMatrix{m}(p1,p2)=equlidianDist(tmpPoint1,tmpPoint2);
    end
end

%%%%%%%%%%%%%
iind1.RVP(m).val=1:(length(particle1.RVP(m).x));
for i=1:(length(particle1.RVP(m).x))
    [~,iind2.RVP(m).val(i)]=min(adjaMatrix{m}(i,:))
    adjaMatrix{m}(:,iind2.RVP(m).val(i))=inf; 
end
end

end

