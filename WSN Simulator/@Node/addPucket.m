function buff = addPucket(n,buff)
global timeCounter;
momentOfGeneration = timeCounter;
newPucket = Pucket(momentOfGeneration);
buff.puckets = [buff.puckets newPucket];
end
