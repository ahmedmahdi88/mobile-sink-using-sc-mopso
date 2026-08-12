function pos=checkBounds(pos)
A=100;
sensorsPos=[pos];

duplicate_ind=[];
while length(unique(sensorsPos))~=length(sensorsPos)
   [~, ind] = unique(sensorsPos);
 duplicate_ind = setdiff(1:length(sensorsPos), ind);
    sensorsPos(duplicate_ind)=round(unifrnd(1,A,1,length(duplicate_ind)));
end
pos=sensorsPos;
end