% v = []
len = sqrt(v(:,1).*v(:,1) + v(:,2).*v(:,2) + v(:,3).*v(:,3));
v = [v(:,1)./len, v(:,2)./len, v(:,3)./len,];
% acos(dot(a,b)/(norm(a)*norm(b)));
z = [0,0,1];
for i = 1:length(len)
    angle(i) = acos(dot(z,v(i,:))/(norm(z)*norm(v(i,:))));
end
