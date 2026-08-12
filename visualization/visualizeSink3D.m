function visualizeSink3D(env,pos)
sensorsRadius=1;
clusterRadius=5;
rvpRadius=2;
W=20;
L=20;
H=20;
%% visualize sensors
n=20;
theta = (-n:2:n)/n*pi;
phi = (-n:2:n)'/n*pi/2;
cosphi = cos(phi); cosphi(1) = 0; cosphi(n+1) = 0;
sintheta = sin(theta); sintheta(1) = 0; sintheta(n+1) = 0;
tz=0:0.01:pi;
xVec=env.sensors(:,1:2:end);
yVec=env.sensors(:,2:2:end);
zVec=zeros(size(xVec));
pl1=plot3(xVec,yVec,zVec,'bx');xlim([0 W]);ylim([0 L]),zlim([0 H]);
hold on;
for i=1:length(xVec)
   thisX = sensorsRadius * cosphi*cos(theta) + xVec(i);
    thisY = sensorsRadius * cosphi*sintheta + yVec(i);
    thisZ = sensorsRadius*sin(phi)*ones(1,n+1)+ zVec(i);
    pl2=plot3(thisX,thisY,thisZ,'g');hold on;
    fill3(thisX, thisY,thisZ,'g','FaceAlpha',0.1,'LineStyle',':');
    grid on;
end
%% visualize clusters
numClusters=pos(1);
xClusters=pos.CH.x;
yClusters=pos.CH.y;
pl3=plot(xClusters,yClusters,'ko');
for i=1:length(xClusters)
    thisX = clusterRadius * cos(theta) + xClusters(i);
    thisY = clusterRadius * sin(theta) + yClusters(i);
   pl4= plot(thisX,thisY,'m');hold on;
end
%% visulize mobileSinks
index=numClusters*2+2;
MS=pos(index);
xMS=pos(index+1:2:index+MS*2);
yMs=pos(index+2:2:index+MS*2);
zMs=15*ones(size(xMS));
pl5=plot3(xMS,yMs,zMs,'bx','MarkerSize',10,'LineWidth',2);
% h2=plot3(xMS,yMs,zMs,'ko','MarkerSize',20,'LineWidth',2);
for i=1:MS
Li=line([xMS(i) xMS(i)],[yMs(i) yMs(i)],[zMs(i) 0],'Color','red','LineWidth',2,'LineStyle',':');
end

% direction=[1,0,0];
% rotate(h1,direction,15);
% rotate(h2,direction,15);
xlim([0 W]);ylim([0 L]),zlim([0 H]);
%% visualize rvps
index=index+MS*2+1;
MK=pos(index);
xMK=pos(index+1:2:index+MK*2);
yMK=pos(index+2:2:index+MK*2);
zMK=zeros(size(xMK));
pl6=plot(xMK,yMK,'ks');
for i=1:length(xMK)
   thisX = rvpRadius * cosphi*cos(theta) + xMK(i);
    thisY = rvpRadius * cosphi*sintheta + yMK(i);
    thisZ = rvpRadius*sin(phi)*ones(1,n+1)+ zMK(i);
    pl7=plot3(thisX,thisY,thisZ,'r');hold on;
    fill3(thisX, thisY,thisZ,'r','FaceAlpha',0.1,'LineStyle',':');
    grid on;
end
xx=[19.9 xMK 19.9];
yy=[19.9 yMK 19.9];
zz=15*ones(size(xx));

for k=1:length(xx)-1
     pause(1);
     set(pl5,'XData',xx(k+1),'YData',yy(k+1),'ZData',zz(k+1));
     set(Li,'XData',[xx(k+1) xx(k+1)],'YData',[yy(k+1) yy(k+1)],'ZData',[zz(k+1) 0]);
     five= plot3([xx(k) xx(k+1)],[yy(k) yy(k+1)],[zz(k) zz(k+1)],'Color',[0.8 0 1],'linewidth',2,'linestyle',':');
end

% pl1
% pl2
legend([pl1,pl2(1),pl3,pl4,pl6,pl7(1),pl5],'Sensor','Sensor Range','Cluster Head','Cluster Range','RVP','RVP Range','Robot')
