clear;
load listname;
for i = 23:31
    if i == 26 || i == 27
        continue
    end
    load(['CroppedBBox\Sign_',listname{i},'.mat']);
    load([listname{i},'.mat']);
    temp = XI;
    XI = -YI;
    YI = ZI; % a larger YI corresponding to a taller thing;
    ZI = -temp;
    
    [result, loc] = min(traffic_sign(:,3));
    id = traffic_sign(loc,1);
    center = [XI(id),YI(id),ZI(id)];
    
    % papering an initializing area (radius < 2m)
    DIFF_XI = XI-center(1);
    DIFF_YI = YI-center(2);
    DIFF_ZI = ZI-center(3);
    Distance = DIFF_XI.*DIFF_XI + DIFF_YI.*DIFF_YI + DIFF_ZI.*DIFF_ZI;
    area = Distance<4;
    X = XI(area);
    Y = YI(area);
    Z = ZI(area);
    ID_AREA = ID(area);
    
    traffic_poles = [];
    
    % expanding a new container until reaching the ground (y = -1.44)
    for j = 1:length(X)
        DIFF_X = X-XI(id);
        DIFF_Y = Y-YI(id);
        DIFF_Z = Z-ZI(id);
        Distance = sqrt(DIFF_X.*DIFF_X + DIFF_Y.*DIFF_Y + DIFF_Z.*DIFF_Z);
        area_t = Distance<0.1;
        X_t = X(area_t);
        Y_t = Y(area_t);
        Z_t = Z(area_t);
        ID_t = ID_AREA(area_t);
        if j > 3 % do not contain any signs
            traffic_poles = [traffic_poles;[ID_t,X_t,Y_t,Z_t]];
        end
        [res, loc] = min(Y_t);
        if res < -1.30
            disp('reach the ground!');
            break;
        end
        id = ID_t(loc);
    end
    csvwrite(['Pole\pole_',listname{i},'.csv'],traffic_poles);
    save(['Pole\pole_',listname{i}],'traffic_poles');
end
%  ptCloud = pointCloud([X_t,Y_t,Z_t]);pcshow(ptCloud)
%

