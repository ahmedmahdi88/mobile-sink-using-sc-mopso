% figure;
[marker,m] = imread('transDrone.png');
marker = imresize(marker,0.5);
marker=flipud(marker);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sensorsRadius=40;
clusterRadius=60;
rvpRadius=40;
W=300;
L=300;
% H=300;
%% visualize sensors
% subplot 211;
xVec=env.sensors(:,1:2:end);
yVec=env.sensors(:,2:2:end);
pl1=plot(xVec,yVec,'bo','linewidth',1);
set(pl1,'markerfacecolor','b');
% set(gca,'YDir','reverse');
set(gca,'YDir','normal')
% set(gca,'color','g');
drawnow;
xlim([0 W]);ylim([0 L]);
hold on;

%% visualize clusters
pos=sol;
xClusters=xCH;
yClusters=yCH;
pl3=plot(xClusters,yClusters,'ro','MarkerSize',10,'linewidth',1);
%% visulize mobileSinks
% Extract rvps x,y coordinates
for m=1:nMS
    for r=1:length(RVP(m).x)
        plot(RVP(m).x(r),RVP(m).y(r),'kx','MarkerSize',10,'linewidth',1);
    end
end
% theta=[0,0];
if ~exist('hh','var')
    for m=1:nMS
        x=ms(m).x;
        y=ms(m).y;
        markersize =[20 20];
        x_low = x - markersize(1)/2; %//Left edge of marker
        x_high = x + markersize(1)/2;%//Right edge of marker
        y_low = y - markersize(2)/2; %//Bottom edge of marker
        y_high = y + markersize(2)/2;%//Top edge of marker
        %     hh(m)=quiver(ms(m).x,ms(m).y,10*cosd(theta(m)),10*sind(theta(m)),...
        %         'm','markerSize',100,'linewidth',2);
        imagesc([x_low x_high], [y_low y_high],marker)
    end
end
%% communication channels
for nod = 1:length(xNodes)
    if ~(nodes(nod).isCH)
        xNod = nodes(nod).x;
        yNod = nodes(nod).y;
        xDist = nodes(nodes(nod).distNode).x;
        yDist = nodes(nodes(nod).distNode).y;
        plDist = plot([xNod xDist],[yNod yDist]);
        uistack(plDist,'top')
        set(plDist,'color','k');
    end
end
%% cheads rvps communication channels
for nod = 1:length(xNodes)
    if (nodes(nod).isCH)
        xNod = nodes(nod).x;
        yNod = nodes(nod).y;
        xDist = xRVP(nodes(nod).distRVP);
        yDist = yRVP(nodes(nod).distRVP);
        xMS = [ms.x];
        yMS = [ms.y];
        if any(xMS==xDist & yMS==yDist)
            p1 = [xNod yNod];
            p2 = [xDist yDist];
            D = p2-p1;
            AmpDist = pdist2([p1(1), p1(2)],[p2(1) ,p2(2)]);
            angle = atan2(p2(2)-p1(2),p2(1)-p1(1));
            for rad =1:3
                radius = AmpDist*(rad/3);
                startAng = angle - pi/6;
                endAng = angle + pi/6;
                plDist(rad) = plotArc(radius,startAng,endAng,p1(1),p1(2));
                pause(0.1);
                %     uistack(plDist,'top')
                %     set(plDist,'color','r','linewidth',1.5,'linestyle',':');
            end
        end
        delete(plDist);
    end
end
%% add legends
h1 = plot(NaN,NaN,'bo','MarkerFaceColor','b');
h2 = plot(NaN,NaN,'ro');
h3 = plot(NaN,NaN,'k-');
h4 = plot(NaN,NaN,'kx');
h5 = plot(NaN,NaN,'r-');
legend([h1,h2,h3,h4,h5],{'Node','CH','Communication Channel',...
    'RVP','Data Propagation'},'location',...
    'eastoutside','orientation','vertical');
%% measures visualization
% subplot 212;
% pdrP = plot(timeCounter,PDR,'rs');
% hold on;
% drawnow;
% e2eP = plot(timeCounter,E2EDelay,'ko');


