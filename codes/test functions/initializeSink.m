function env=initializeSink(numberOfSensors)
W=300;
H=300;
sensorsRadius=40;
A=W*H;
sensors=unifrnd(0,W-0.1,1,numberOfSensors*2);

% duplicate_ind=[];
% while length(unique(sensorsPos))~=length(sensorsPos)
%    [~, ind] = unique(sensorsPos);
%  duplicate_ind = setdiff(1:length(sensorsPos), ind);
%  sensors(duplicate_ind).x=unifrnd(0,W-0.1,1,length(duplicate_ind));
%   sensors(duplicate_ind).y=unifrnd(0,H-0.1,1,length(duplicate_ind));
%   sensorsPos(duplicate_ind)=sqrt((sensors(duplicate_ind).x).^2+(sensors(duplicate_ind).y).^2);
% end
env.sensors=sensors;

theta = 0 : 0.01 : 2*pi;

xVec=env.sensors(:,1:2:end);
yVec=env.sensors(:,2:2:end);
plot(xVec,yVec,'bx');xlim([0 W]);ylim([0 H]);
hold on;
for i=1:length(xVec)
    thisX = sensorsRadius * cos(theta) + xVec(i);
    thisY = sensorsRadius * sin(theta) + yVec(i);
%     plot(thisX,thisY,'g');hold on;
end

% for ir=1:length(env.rndVoz)
%         plot(env.rndVoz(ir).x,env.rndVoz(ir).y,'kx');xlim([0 W]);ylim([0 H]);
%         hold on;
%         thisX = rendiRadius * cos(theta) + env.rndVoz(ir).x;
%         thisY = rendiRadius * sin(theta) + env.rndVoz(ir).y;
%         plot(thisX,thisY,'r');hold on;
% end
% env.robot.start.x=W-1;
% env.robot.start.y=H-1;
% env.robot.visitedPos=[];
%
% plot(env.robot.start.x,env.robot.start.y,'md','MarkerSize',20)
% hold off;
end




