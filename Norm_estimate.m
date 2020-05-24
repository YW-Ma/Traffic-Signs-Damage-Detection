% workflow: 4
% implement local norm estimation for the (traffic signs) points
standard = [];
for i=[1,2,3,4,12]
    load(['CroppedBBox\Sign_',listname{i},'.mat']);
    ptCloud = pointCloud(traffic_sign(:,2:4));
    normals = pcnormals(ptCloud);
    
    x = ptCloud.Location(1:4:end,1);
    y = ptCloud.Location(1:4:end,2);
    z = ptCloud.Location(1:4:end,3);
    u = normals(1:4:end,1);
    v = normals(1:4:end,2);
    w = normals(1:4:end,3);
    
    sensorCenter = [0,-0.3,0.3];
    for k = 1 : numel(x)
        p1 = sensorCenter - [x(k),y(k),z(k)];
        p2 = [u(k),v(k),w(k)];
        % Flip the normal vector if it is not pointing towards the sensor.
        angle = atan2(norm(cross(p1,p2)),p1*p2');
        
        if angle > pi/2 || angle < -pi/2
            u(k) = -u(k);
            v(k) = -v(k);
            w(k) = -w(k);
        end
    end
    figure('color','w')
    pcshow(ptCloud)
    % title('局部法向量')
    hold on
    quiver3(x,y,z,u,v,w)
    % quiver3(5,5,-10,mean(u),mean(v),mean(w));
    % bar([-w,-u,v],'stack');
    % legend('X分量','Y分量','Z分量')
    % xlabel('激光点序号');
    % ylabel('各分量的数值');
    
%     [idx,C,sumd,D] = kmeans([u,v,w],1);
%     color = ['g','r','b'];
%     cls_1 = idx == 1;
%     cls_2 = idx == 2;
%     quiver3(x(cls_1), y(cls_1), z(cls_1), u(cls_1), v(cls_1), w(cls_1),'g');
    % quiver3(x(cls_2), y(cls_2), z(cls_2), u(cls_2), v(cls_2), w(cls_2),'g');
    
    hold off
    standard(i,:) = std([-w,-u,v]);
    
end
