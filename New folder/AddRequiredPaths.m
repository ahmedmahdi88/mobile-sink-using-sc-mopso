currentFolder = pwd;
while ~strcmp(currentFolder(end-1:end),'#\')
    currentFolder(end) = [];
end

