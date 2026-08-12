function f= updatedMobileSinkObjFun(pos,cId,env)
% note: node=sensor
cId=str2num(cId);
N=cId(1);
k=1;
Eelec=1;
eFs=0.01;
eMp=0.018;
d0=40;
d02=40;
robotVel=2;
stopTime=1;
clusterRadius=60;
sensorRadius=40;
rvpRadius=40;
%% find the closest CH to each node
% we need an adjancacy matrix
Xclusters=pos.CH.x(1:N);
Yclusters=pos.CH.y(1:N);
% N=length(Xclusters);
Nnodes=length(env.sensors)/2; % nodes number
nodes=env.sensors;
Xnodes=nodes(1:2:end);
Ynodes=nodes(2:2:end);
adjaMat=zeros(Nnodes,N);
for i=1:Nnodes
    node=[Xnodes(i) Ynodes(i)];
    for j=1:N
        CH=[Xclusters(j) Yclusters(j)];
        adjaMat(i,j)=equlidianDist(node,CH);
    end
end
%% we need mapping matrix (mapping between each sensor and corresponding
% cluster
mapMat=zeros(Nnodes,2);
for i=1:Nnodes
    mapMat(i,1)=i;
    [dist(i),mapMat(i,2)]=min(adjaMat(i,:));
    if dist(i)>clusterRadius
        mapMat(i,2)=nan;
    end
end
CHnumberOfRepeated = arrayfun(@(x)length(find( mapMat(:,2) == x)), unique(mapMat(:,2)), 'Uniform', false);
CHnumberOfRepeated=cell2mat(CHnumberOfRepeated);
a=unique(mapMat(:,2));
while length(a)<N
idx=find(~ismember(1:N,a));
for i=idx
len=length(a);
a(i+1:len+1)=a(i:len);
a(i)=0;
CHnumberOfRepeated(i+1:len+1)=CHnumberOfRepeated(i:len);
CHnumberOfRepeated(i)=0;
end
end
%% compute Etx for each node (from sensor to CH)
for i=1:Nnodes
    if isnan(mapMat(i,2))
        E(i)=0;
    else
        if dist(i)<=d0
        E(i)=Eelec*k+eFs*k*dist(i)^2;
        else
        E(i)=Eelec*k+eMp*k*dist(i)^4;
        end
    end
end
%% number of mobile sinks
% MS=pos(N*2+2);
%% find Energy consumption by sending data from CH to RVP
% first we need to creat adjaMat for CHs and RVPs
% extract rvps coordinates vectors
xRVP=[];
yRVP=[];
% MS=numel(pos.RVP);
MS=cId(2);
rvpNums=cId(3:end);
for m=1:MS
  xRVP=[xRVP   pos.RVP(m).x(1:rvpNums(m))];
  yRVP=[yRVP   pos.RVP(m).y(1:rvpNums(m))];
end
% compute adjaMat
adjaMat2=zeros(length(xRVP),length(Xclusters));
for i=1:length(Xclusters)
    cluster=[Xclusters(i) Yclusters(i)];
    for j=1:length(xRVP)
        rvp=[xRVP(j) yRVP(j)];
        adjaMat2(i,j)=equlidianDist(rvp,cluster);
    end
end
% now create mapping matrix between each rvp and corresponding cluster head
mapMat2=zeros(N,2);
dist2=zeros(N,1);
for i=1:N
    mapMat2(i,1)=i;
    [dist2(i),mapMat2(i,2)]=min(adjaMat2(i,:));
    if dist2(i)>sensorRadius+rvpRadius
        mapMat2(i,2)=nan;
    end 
end
% now compute energy consumption by sending data from cluster head to rvp
E2=zeros(N,1);
for i=1:N
    if ~isnan(mapMat2(i,2)) 
        if dist2(i)<d02
        E2(i)=Eelec*k*CHnumberOfRepeated(i)+eFs*k*CHnumberOfRepeated(i)*dist2(i)^2;
        else
        E2(i)=Eelec*k*CHnumberOfRepeated(i)+eMp*k*CHnumberOfRepeated(i)*dist2(i)^4;
        end
    end
end

%% compute travelling time 
% calculate adjancacy matrix for each mobile sink and find shortest distance path
for k=1:MS
    x{k}=pos.RVP(k).x(1:rvpNums(k));
    y{k}=pos.RVP(k).y(1:rvpNums(k));
end

for k=1:MS
    rvpAdja{k}=zeros(length(x{k}));
    for r=1:length(x{k})
        p1=[x{k}(r) y{k}(r)];
        for rr=1:length(x{k})
            p2=[x{k}(rr) y{k}(rr)];
            if r==rr
                rvpAdja{k}(r,rr)=inf;
            else
            rvpAdja{k}(r,rr)=equlidianDist(p1,p2);
            end
        end
    end
end
for k=1:MS
    seq{k}(1)=1;
    p1=x{k}(1);
    for ii=1:length(x{k})
        [~,idx]=min(rvpAdja{k}(ii,:));
        rvpAdja{k}(:,idx)=inf;
         seq{k}= [seq{k} idx];
    end
end
% compute travelling time for each mobile sink
for k=1:MS
    travDist(k)=0;
    travTime(k)=0;
    for sq=1:length(seq{k})-1
        s=seq{k}(sq);
        s2=seq{k}(sq+1);
        p1=[x{k}(s) y{k}(s)];
        p2=[x{k}(s2) y{k}(s2)];
        travDist(k)=travDist(k)+equlidianDist(p1,p2);
        travTime(k)=travTime(k)+travDist(k)/robotVel+...
        stopTime*(length(seq{k})-2);  
    end
end
f(1)= sum(E); % energy consumption for sending data from nodes to CHs
f(2)= sum(E2);% energy consumption for sending data from CHs to RV points 
f(3)= 0.5*std(E)+0.5*std(E2); % energy distribution among the node
f(4)= sum(travTime); % travelling time
f(5)= MS; % number of mobile sinks
end
%% the end
    

    


