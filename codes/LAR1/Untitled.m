clc
clear 
close all
load roads

roads1=roads;
roads=cell(size(roads1,1)+1,size(roads1,1));

for i=1:3
    for j=1:7
        roads{i,j}=roads1{i,j};
    end
end
roads{4,1}=16.5;
roads{4,2}=20;
roads{4,3}=25;
roads{4,4}=25;
roads{4,5}=22;
roads{4,6}=27.5;
roads{4,7}=27.5;

im=imread('roads.png');
im=imresize(im,[500 500]);
imshow(im)

clear im roads1 i j