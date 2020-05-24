for i = [5,6,12,1]
    load(['CroppedBBox\Sign_',listname{i},'.mat']);
    traffic_sign(:,5) = (traffic_sign(:,5)-min(traffic_sign(:,5)))/(max(traffic_sign(:,5))-min(traffic_sign(:,5)));
    [idx,C,sumd,D] = kmeans(traffic_sign(:,5),2);
    traffic_sign(:,8) = idx;
    hist(traffic_sign(:,5),100);
    ylabel('频数');
    xlabel('反射率强度值（归一化）');
    result = [traffic_sign(:,2:4),traffic_sign(:,8)];
    cls_1 = (sum(result(:,4))-(sum(result(:,4)) - length(result))*2);cls_2 = (sum(result(:,4)) - length(result)); ratio = cls_1/cls_2;
    csvwrite(['CroppedBBox\Sign_Overlay_Estimate_',listname{i},'.csv'],result);
end