clear;
load listname
load camera_vector.mat % orientation vector for the camera.

i = 13;
load(['CroppedBBox\Sign_',listname{i},'.mat']);
traffic_sign(:,5) = (traffic_sign(:,5)-min(traffic_sign(:,5)))/(max(traffic_sign(:,5))-min(traffic_sign(:,5)));

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
        continue
    end
    u(k) = -u(k);
    v(k) = -v(k);
    w(k) = -w(k);
end

pcshow(ptCloud)
title('局部法向量(蓝)交通标志法向量(红)道路通行方向（黄）')
hold on
quiver3(x, y, z, u, v, w);

norm_vector = [mean(u),mean(v),mean(w)];
%normalization
norm_vector = norm_vector./(norm(norm_vector));
camera_vector = camera_vector./(norm(camera_vector));

quiver3(mean(x),mean(y),mean(z),mean(u),mean(v),mean(w));
quiver3(mean(x),mean(y),mean(z),camera_vector(1),camera_vector(2),camera_vector(3));
angle = rad2deg(acos(dot(camera_vector,norm_vector)/(norm(camera_vector)*norm(norm_vector))));
hold off;