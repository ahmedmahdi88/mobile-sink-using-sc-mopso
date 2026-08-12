function visualizeSink2DSim(xNodes,yNodes,pos)
sensorsRadius=40;
clusterRadius=60;
rvpRadius=40;
W=300;
L=300;
H=300;
%% visualize sensors
n=20;
theta = (-n:2:n)/n*pi;
xVec=xNodes;
yVec=yNodes;
pl1=plot(xVec,yVec,'bx');
xlim([0 W]);ylim([0 L]);
hold on;
for i=1:length(xVec)
    thisX = sensorsRadius *cos(theta) + xVec(i);
    thisY = sensorsRadius *sin(theta) + yVec(i);
    pl2=plot(thisX,thisY,'g');hold on;
    fill(thisX, thisY,'g','FaceAlpha',0.1,'LineStyle',':');
    
end
%% visualize clusters
numClusters=length(pos.CH.x);
xClusters=pos.CH.x;
yClusters=pos.CH.y;
pl3=plot(xClusters,yClusters,'ro','MarkerSize',10);
for i=1:length(xClusters)
    thisX = clusterRadius * cos(theta) + xClusters(i);
    thisY = clusterRadius * sin(theta) + yClusters(i);
    pl4= plot(thisX,thisY,'m');hold on;
end
%% visulize mobileSinks
% Extract rvps x,y coordinates
MS=numel(pos.RVP);
for m=1:MS
    xRVP{m}=pos.RVP(m).x;
    yRVP{m}=pos.RVP(m).y;
end
% computing the adjancacy matrix for each mobile sink
for m=1:MS
    for i=1:length(xRVP{m})
        p1=[xRVP{m}(i) yRVP{m}(i)];
        for j=1:length(xRVP{m})
            if i==j
                adjaMat{m}(i,j)=inf;
            else
                p2= [xRVP{m}(j) yRVP{m}(j)];
                adjaMat{m}(i,j)= equlidianDist(p1,p2);
            end
        end
    end
end
% finding the shortest path for each mobile sink
for m=1:MS
    seq{m}=1;
    tmpInd=1;
    for i=1:length(xRVP{m})
        adjaMat{m}(:,tmpInd)=inf;
        [~,tmpInd]= min(adjaMat{m}(tmpInd,:));
        seq{m}=[seq{m} tmpInd];
    end
end
% start visualization
for m=1:MS
    h=plot(xRVP{m}(seq{m}(1)),yRVP{m}(seq{m}(1)),'^m','MarkerEdgeColor','r','MarkerSize',20);
    thisX = sensorsRadius *cos(theta) + xRVP{m}(seq{m}(1));
    thisY = sensorsRadius *sin(theta) + yRVP{m}(seq{m}(1));
    pl55=plot(thisX,thisY,'r');hold on;
    pl56=fill(thisX, thisY,'r','FaceAlpha',0.1,'LineStyle',':');
    
    for s=2:length(seq{m})
        set(h,'XData',xRVP{m}(seq{m}(s)),'YData',yRVP{m}(seq{m}(s)));
        set(pl55,'XData',xRVP{m}(seq{m}(s)),'YData',yRVP{m}(seq{m}(s)));
        set(pl56,'XData',xRVP{m}(seq{m}(s)),'YData',yRVP{m}(seq{m}(s)));
        plot([xRVP{m}(seq{m}(s-1)) xRVP{m}(seq{m}(s))] ,[yRVP{m}(seq{m}(s-1)) yRVP{m}(seq{m}(s))],'b');
        pause(0.5);
    end
    
    
end
end

% legend([pl1,pl2,pl3,pl4,pl5,pl6,pl7],{'Sensor','Sensor Range','Cluster Head','Cluster Range','Robot','RVP','RVP Range'})
