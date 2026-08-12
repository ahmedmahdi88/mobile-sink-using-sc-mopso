function pos=checkBoundsSink(sensorPos,dim,env)
A=19.9;
duplicate_ind=[];
% d_ind=[];
% for i=1:length(env.sensors)
%     d=[];
%     xySensor=[env.sensors(i).x env.sensors(i).y];
%     for j=1:length(sensorPos.x)
%        xyRend=[sensorPos.x(j) sensorPos.y(j)];
%         d(j)=equlidianDist(xySensor,xyRend);
%     end
%    [md,index]=min(d)
%     if md>3
%         d_ind=[d_ind index];
%     end
% end

sensorsPos=[sensorPos];
amb=(sensorsPos.x(1:dim).^2+sensorsPos.y(1:dim).^2);

while length(unique(amb))~=length(amb) 
   [~, ind] = unique(amb);
 duplicate_ind = [setdiff(1:length(amb), ind)];
%  duplicate_ind=unique(duplicate_ind);
    sensorsPos.x(duplicate_ind)=(unifrnd(0,A,1,length(duplicate_ind)));
    sensorsPos.y(duplicate_ind)=(unifrnd(0,A,1,length(duplicate_ind)));
    amb=(sensorsPos.x(1:dim).^2+sensorsPos.y(1:dim).^2);
  
% for i=1:length(env.sensors)
%     d=[];
%     xySensor=[env.sensors(i).x env.sensors(i).y];
%     for j=1:length(sensorPos.x)
%        xyRend=[sensorPos.x(j) sensorPos.y(j)];
%         d(j)=equlidianDist(xySensor,xyRend);
%     end
%    [md,index]=min(d)
%     if md>3
%         d_ind=[d_ind index];
%     end
end

pos=sensorsPos;
end