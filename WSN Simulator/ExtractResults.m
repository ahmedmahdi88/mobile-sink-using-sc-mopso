%% 
clear;
clc;
close all;
%%
cnt=0;
% cost=7;
algo = {'SC-MOPSO' , 'MOPSO-mutation', 'MOPSO','NSGA2'};
for al=1:4
for seed = [5 11 1 2 4 7  6 3 ]
dir2 = [cd '/simulation results - timeSeries3/' algo{al} '/seed ' num2str(seed)];
Files = dir(dir2);
for i = 3:numel(Files)
    cnt=cnt+1;
   res{cnt}= load([dir2 '/' Files(i).name]);
   delete(res{cnt}.wb);
   res{cnt}.wb=[];
end
end
end
