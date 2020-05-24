clear;
load listname;
for i = 11:12
    % skip the empty ones
    if i == 7 || i == 8 || i == 9 || i == 10 || i == 21 || i == 22 || i == 26 || i == 27 || i == 32
        continue
    end
    load(['CroppedBBox\',listname{i},'.mat']);
    n = [sum(container(:,6)==1),sum(container(:,6)==2),sum(container(:,6)==3)];
    [number, cls] = max(n);
    temp = container(:,6)==cls;
    traffic_sign = container(temp,:);
    if isempty(traffic_sign)
        continue
    end
    csvwrite(['CroppedBBox\Sign_',listname{i},'.csv'],traffic_sign);
    save(['CroppedBBox\Sign_',listname{i},'.mat'],'traffic_sign');
end