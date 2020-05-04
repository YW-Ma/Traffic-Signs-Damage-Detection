[idx,C,sumd,D] = kmeans(container(:,1:3),6);
container(:,5) = idx;
