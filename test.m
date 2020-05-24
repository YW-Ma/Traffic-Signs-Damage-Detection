% load something
clear
load good_for_station2_real.mat
img = imread('Station2\Rotation030.JPG');
input = [14.786,-8.273,1.368];

% Xi = input(1);
% Yi = input(2);
% Zi = input(3);
Xi = -input(2);
Yi = input(3);
Zi = -input(1);
R(1, 1) = cos(Phi)*cos(Kappa) - sin(Phi)*sin(Omega)*sin(Kappa);
R(1, 2) = cos(Omega)*sin(Kappa);
R(1, 3) = sin(Phi)*cos(Kappa) + cos(Phi)*sin(Omega)*sin(Kappa);
R(2, 1) = -cos(Phi)*sin(Kappa) - sin(Phi)*sin(Omega)*cos(Kappa);
R(2, 2) = cos(Omega)*cos(Kappa);
R(2, 3) = -sin(Phi)*sin(Kappa) + cos(Phi)*sin(Omega)*cos(Kappa);
R(3, 1) = -sin(Phi)*cos(Omega);
R(3, 2) = -sin(Omega);
R(3, 3) = cos(Phi)*cos(Omega);
XR = R(1, 1)*(Xi - Xs) + R(1, 2)*(Yi - Ys) + R(1, 3)*(Zi - Zs);
YR = R(2, 1)*(Xi - Xs) + R(2, 2)*(Yi - Ys) + R(2, 3)*(Zi - Zs);
ZR = R(3, 1)*(Xi - Xs) + R(3, 2)*(Yi - Ys) + R(3, 3)*(Zi - Zs);
xi = -f * XR / ZR + x0;
yi = -f * YR / ZR + y0;
%draw several point in the photo.

x = xi;
y = yi;
%convert
x = floor(x+1544);
y = floor(1028-y);
color = [255,0,0];
len = 20;
width = 2;
for c = 1:3
    for w = -width:width
        img(y-len:y+len, x+w, c) = color(c);
        img(y+w, x-len:x+len, c) = color(c);
    end
end


imshow(img);