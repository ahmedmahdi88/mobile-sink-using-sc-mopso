function state=CheckIfIamInsideRequestZone(n,requestZone)

x=n.xNode;
y=n.yNode;
if(isempty(requestZone))
    
     state=false;
    return;
end

A=requestZone(1,:);
%B=requestZone(2,:);
C=requestZone(3,:);
%D=requestZone(4,:);

if x<A(1) || x>C(1) || y<A(2) || y>C(2)
    state=false;
    return;
end

state=true;

end