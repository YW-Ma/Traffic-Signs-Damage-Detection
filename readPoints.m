% workflow: 1
% read laser points from a TXT file.
clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Disappear001.txt','%n%f%f%f%f','delimiter',',');
save Disappear001.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Disappear002.txt','%n%f%f%f%f','delimiter',',');
save Disappear002.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Hou001.txt','%n%f%f%f%f','delimiter',',');
save Hou001.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Hou002.txt','%n%f%f%f%f','delimiter',',');
save Hou002.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Hou003.txt','%n%f%f%f%f','delimiter',',');
save Hou003.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Normal.txt','%n%f%f%f%f','delimiter',',');
save Normal.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Qian001.txt','%n%f%f%f%f','delimiter',',');
save Qian001.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Qian002.txt','%n%f%f%f%f','delimiter',',');
save Qian002.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Qian003.txt','%n%f%f%f%f','delimiter',',');
save Qian003.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Qian004.txt','%n%f%f%f%f','delimiter',',');
save Qian004.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Zuo002.txt','%n%f%f%f%f','delimiter',',');
save Zuo002.mat ID XI YI ZI INTENSITY

clear;
[ID,XI,YI,ZI,INTENSITY] = textread('Station1\Zuo003.txt','%n%f%f%f%f','delimiter',',');
save Zuo003.mat ID XI YI ZI INTENSITY