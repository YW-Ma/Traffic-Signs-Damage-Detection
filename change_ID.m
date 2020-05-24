clear;
load listname;
i = 31;

load([listname{i},'.mat']);
for j = 1:length(ID)
    ID(j) = j;
end

save([listname{i},'.mat'],'ID','XI','YI','ZI','INTENSITY');