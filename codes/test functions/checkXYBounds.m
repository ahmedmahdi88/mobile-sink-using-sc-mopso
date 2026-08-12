function pos=checkXYBounds(pos,lowerBound_pos,heighrerBounds_pos)
pos.CH.x(pos.CH.x<lowerBound_pos)=lowerBound_pos;
pos.CH.y(pos.CH.y<lowerBound_pos)=lowerBound_pos;
pos.CH.x(pos.CH.x>heighrerBounds_pos)=heighrerBounds_pos;
pos.CH.y(pos.CH.y>heighrerBounds_pos)=heighrerBounds_pos;
%%%%
for i=1:numel(pos.RVP)
pos.RVP(i).x(pos.RVP(i).x<lowerBound_pos)=lowerBound_pos;
pos.RVP(i).y(pos.RVP(i).y<lowerBound_pos)=lowerBound_pos;
pos.RVP(i).x(pos.RVP(i).x>heighrerBounds_pos)=heighrerBounds_pos;
pos.RVP(i).y(pos.RVP(i).y>heighrerBounds_pos)=heighrerBounds_pos;
end
end