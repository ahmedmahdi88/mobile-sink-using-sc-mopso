function [valid nonCoveredNode cs]=checkConstraints(tmp,sr,cR,xNodes,yNodes)
distNodeClustThresh=cR;
xCH=tmp.CH.x;
yCH=tmp.CH.y;
nodesClustersAdjaMat=zeros(length(xNodes),length(xCH));
     % adjancacy matrix
     for nod=1:length(xNodes)
         p1=[xNodes(nod) yNodes(nod)];
         for clust=1:length(xCH)
             p2=[xCH(clust) yCH(clust)];
             nodesClustersAdjaMat(nod,clust)=equlidianDist(p1,p2);
         end
     end
     % find the closest cluster to each node
     shorDist=[];
     closestClust=[];
     for nod=1:length(xNodes)
     [shorDist(nod,:),closestClust(nod,:)]=mink(nodesClustersAdjaMat(nod,:),length(xCH));
     end
     if any(shorDist(:,1)>distNodeClustThresh)
         Bool=0;
     else
         Bool=1;
     end
     xmk=[];
     ymk=[];
     xch=[];
     ych=[];
     sR=40;
     rvpR=40;
     xch=tmp.CH.x;
     ych=tmp.CH.y;
     for ijk=1:numel(tmp.RVP)
         xmk=[xmk tmp.RVP(ijk).x];
         ymk=[ymk tmp.RVP(ijk).y];
     end
     [cov,~]=computeCov(xmk,ymk,xch,ych,sR,rvpR);
     Bool2=(cov==1);
     valid=Bool && Bool2;
     nonCoveredNode=find(shorDist(:,1)>distNodeClustThresh,1);
     cs= closestClust(nonCoveredNode,:);
end