function plt = plotArc(radius,startAng,endAng,startX,startY)
circr = @(radius,rad_ang)  [startX+radius*cos(rad_ang);  startY+radius*sin(rad_ang)];         % Circle Function For Angles In Radians
circd = @(radius,deg_ang)  [startX+radius*cosd(deg_ang);  startY+radius*sind(deg_ang)];       % Circle Function For Angles In Degrees
N = 25;                                                         % Number Of Points In Complete Circle
r_angl = linspace(startAng, endAng, N);                             % Angle Defining Arc Segment (radians)
xy_r = circr(radius,r_angl);                                    % Matrix (2xN) Of (x,y) Coordinates
plt = plot(xy_r(1,:), xy_r(2,:), 'r')                                % Draw An Arc Of Blue Stars
end