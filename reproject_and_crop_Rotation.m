% workflow: 2
% reproject laser points back to the corresponding image
% crop the points dropping into the bounding box(bbox)
clear
% part 1: for station 2
for i = 11:12
    load listname
    load bbox
    load good_for_station2_real
    load([listname{i},'.mat']);
    situation_name = listname{i};
    % 1: obtain the bbox boundings.
    yy = floor(2056*bbox(i,4));
    xx = floor(3088*bbox(i,3));
    h = floor(2056*bbox(i,1));
    w = floor(3088*bbox(i,2));
    
    top = floor(yy-h/2);
    bottom = floor(yy+h/2);
    left = floor(xx-w/2);
    right = floor(xx+w/2);
    
    %2:color-related stuff.
    % implement linear change on INTENDSITY --> to [1 - 256]
    INTENSITY = (INTENSITY-min(INTENSITY))*255/(max(INTENSITY)-min(INTENSITY))+1;
    INTENSITY = floor(INTENSITY);
    COLOR_MAP = jet(256);  % color map (pseudocolor)
    COLOR = zeros(length(INTENSITY),3);
    for j = 1:length(INTENSITY)
        COLOR(j,:) = COLOR_MAP(INTENSITY(j),:);
    end
    COLOR(:,1) = (COLOR(:,1)-min(COLOR(:,1)))*255/(max(COLOR(:,1))-min(COLOR(:,1)));
    COLOR(:,2) = (COLOR(:,2)-min(COLOR(:,2)))*255/(max(COLOR(:,2))-min(COLOR(:,2)));
    COLOR(:,3) = (COLOR(:,3)-min(COLOR(:,3)))*255/(max(COLOR(:,3))-min(COLOR(:,3)));
    
    %3: display & crop
    img = imread(['Station2\',listname{i},'.JPG']);
    R(1, 1) = cos(Phi)*cos(Kappa) - sin(Phi)*sin(Omega)*sin(Kappa);
    R(1, 2) = cos(Omega)*sin(Kappa);
    R(1, 3) = sin(Phi)*cos(Kappa) + cos(Phi)*sin(Omega)*sin(Kappa);
    R(2, 1) = -cos(Phi)*sin(Kappa) - sin(Phi)*sin(Omega)*cos(Kappa);
    R(2, 2) = cos(Omega)*cos(Kappa);
    R(2, 3) = -sin(Phi)*sin(Kappa) + cos(Phi)*sin(Omega)*cos(Kappa);
    R(3, 1) = -sin(Phi)*cos(Omega);
    R(3, 2) = -sin(Omega);
    R(3, 3) = cos(Phi)*cos(Omega);
    cnt = 0;
    % reproject
    container = [];
    for j=1:length(ID)
        Xi = -YI(j);
        Yi = ZI(j);
        Zi = -XI(j);
        XR = R(1, 1)*(Xi - Xs) + R(1, 2)*(Yi - Ys) + R(1, 3)*(Zi - Zs);
        YR = R(2, 1)*(Xi - Xs) + R(2, 2)*(Yi - Ys) + R(2, 3)*(Zi - Zs);
        ZR = R(3, 1)*(Xi - Xs) + R(3, 2)*(Yi - Ys) + R(3, 3)*(Zi - Zs);
        xi = -f * XR / ZR + x0;
        yi = -f * YR / ZR + y0;
        %draw several point in the photo.
        x = floor(xi+1544);
        y = floor(1028-yi);
        if x<=0 || x>3088 || y<=0 || y>2056
            continue
        end
        % crop and draw
        if x<=right && x>=left && y<=bottom-10 && y>=top
            cnt = cnt+1;
            container(cnt,:)=[ID(j),Xi, Yi, Zi,INTENSITY(j)];
            color = COLOR(i,:);
            for c = 1:3
                img(y,x,c) = color(c);
            end
        end
    end
    if isempty(container)
        continue
    end
    container(:,7) = container(:,2).*container(:,2) + container(:,4).*container(:,4);
    [idx,C,sumd,D] = kmeans(container(:,7),9);
    container(:,6) = idx;
    csvwrite(['CroppedBBox\',listname{i},'.csv'],container);
    save(['CroppedBBox\',listname{i}],'container');
    %     imshow(img);
end