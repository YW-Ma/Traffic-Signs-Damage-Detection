% workflow: 3
% implement clustering analysis to the cropped points in the bbox.
% [x,y,z,intensity, cluterID]
[idx,C,sumd,D] = kmeans(container(:,2:4),6);
container(:,6) = idx;

i = 20;
csvwrite(['CroppedBBox\',listname{i},'.csv'],container);
save(['CroppedBBox\',listname{i}],'container');
