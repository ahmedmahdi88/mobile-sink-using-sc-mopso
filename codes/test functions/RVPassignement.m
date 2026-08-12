function idxx=RVPassignement(xMS,yMS,xMK,yMK,MK)
adjaMat=zeros(length(xMS),length(xMK));
for i=1:length(xMS)
    p1=[xMS(i) yMS(i)];
    for j=1:length(xMK)
    p2=[xMK(j)  yMK(j)];
    adjaMat(i,j)=equlidianDist(p1,p2);
    end
end

for i=1:length(xMS)
    idx=find(adjaMat(i,:)==0,1)
    xRVP{i}(1)=xMK(idx);
    yRVP{i}(1)=yMK(idx);
    idxx{i}=idx;
    adjaMat(:,idx)=inf;
end
adjaMat(adjaMat==0)=inf;
c=1;
for i=1:length(xMS)
    [~,idx]=mink(adjaMat(i,:),MK(i)-1);
    adjaMat(:,idx)=inf;
    idxx{i}=[idxx{i} idx];
end
end