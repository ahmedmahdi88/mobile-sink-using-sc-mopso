function n=NDS(pop)
n=0;
for i=1:numel(pop)
    if ~pop(i).IsDominated
        n=n+1;
    end
end
end