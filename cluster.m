% workflow: 3
% implement clustering analysis to the cropped points in the bbox.
% [x,y,z,intensity, cluterID]
[idx,C,sumd,D] = kmeans(container(:,1:3),6);
container(:,5) = idx;
