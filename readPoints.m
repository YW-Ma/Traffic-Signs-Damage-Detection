% workflow: 1
% read laser points from a TXT file.
clear;
load listname
for i = 1:20
    [ID,XI,YI,ZI,INTENSITY] = textread(['Station2\',listname{i},'.txt'],'%n%f%f%f%f','delimiter',',');
    save([listname{i},'.mat'],'ID','XI','YI','ZI','INTENSITY') ;
end
for i = 21:32
    [ID,XI,YI,ZI,INTENSITY] = textread(['Station1\',listname{i},'.txt'],'%n%f%f%f%f','delimiter',',');
    save([listname{i},'.mat'],'ID','XI','YI','ZI','INTENSITY') ;
end
