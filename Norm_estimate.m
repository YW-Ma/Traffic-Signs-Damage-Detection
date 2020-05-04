% workflow: 4
% implement local norm estimation for the (traffic signs) points

ptCloud = pointCloud(container(1:1401,1:3));
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

figure
pcshow(ptCloud)
title('Adjusted Normals of Point Cloud')
hold on
quiver3(x, y, z, u, v, w);
hold off