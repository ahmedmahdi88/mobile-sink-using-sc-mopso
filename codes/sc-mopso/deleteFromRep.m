function Rep=deleteFromRep(uniq,Rep)
fitness= 10*ones(1,length(Rep));
 counter=zeros(1,length(uniq));
 for j=1:length(uniq)
        
        for i=1:numel(Rep)
            if Rep(i).GridIndex==uniq(j)
                counter(j)=counter(j)+1;
            end
        end
 end

for j=1:length(uniq)
        
        for i=1:numel(Rep)
            if Rep(i).GridIndex==uniq(j)
                fitness(i)= counter(j);
            end
        end
end
    
    P=fitness./sum(fitness);
    h= RouletteWheelSelection(P);
    
Rep(h)=[];
end