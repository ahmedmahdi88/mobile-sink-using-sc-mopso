function requestZone=GetRequestZone(n,destinationNode)

global timeCounter
requestZone=[];
% Determine the expected zone
% The coordinates of center of the expected zone
x=n.locationTable(destinationNode).xNode;
y=n.locationTable(destinationNode).yNode;

% The last moment of update
t0=n.locationTable(destinationNode).t0;

% The radius of the expected zone
%destVel=sqrt((nodes(destinationNode).xNodeVel)^2+(nodes(destinationNode).yNodeVel)^2);
destVel=n.meanVel;
radius=destVel*(timeCounter-t0);

% Determine the request zone
S=[n.xNode n.yNode];
dist=sqrt((x-S(1))^2+(y-S(2))^2);
if dist<radius
    % The source node is inside the expected zone
    A=[x-radius y-radius];
    B=[x+radius y-radius];
    C=[x+radius y+radius];
    D=[x-radius y+radius];
    requestZone=[A;B;C;D];
    return;
end

% The source node is not inside the expected zone
if S(1)<x && S(2)<y
    D=[x+radius y+radius];
    A=[D(1) min(S(2),y-radius)];
    B=[min(S(1),x-radius) D(2)];
    S=[B(1) A(2)];
    requestZone=[S;A;D;B];
elseif S(1)>x && S(2)<y
    D=[x-radius y+radius];
    A=[max(S(1),x+radius) D(2)];
    B=[D(1) min(S(2),y-radius)];
    S=[A(1) B(2)];
    requestZone=[B;S;A;D];
elseif S(1)>x && S(2)>y
    D=[x-radius y-radius];
    A=[D(1) max(S(2),y+radius)];
    B=[max(S(1),x+radius) D(2)];
    S=[B(1) A(2)];
    requestZone=[D;B;S;A];
elseif S(1)<x && S(2)>y
    D=[x+radius y-radius];
    A=[min(S(1),x-radius) D(2)];
    B=[D(1) max(S(2),y+radius)];
    S=[A(1) B(2)];
    requestZone=[A;D;B;S];
end

end