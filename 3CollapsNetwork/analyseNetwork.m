
c=clock;
%timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];
disp('Load networks...');
disp('Loading network');
load('keywordsList.mat');
disp('Load networkT...');
load(['network' timenow '.mat']);
load(['networkT' timenow '.mat']);

disp('Collaps synonyms...');
CollapsSynonyms

disp('Prepare networks...')        

degree=sum(nn>0);
threshold=0;
nn=nn(degree>threshold,:);
nn=nn(:,degree>threshold);
networkT=networkT(degree>threshold,:);
networkT=networkT(:,degree>threshold);             

allKW=allKW(degree>threshold);
degree=degree(degree>0);

disp(['Collapsed to ' num2str(length(nn)) ' keywords.']);

save(['network' timenow 'Collaps.mat'], 'nn')
save(['networkT' timenow 'Collaps.mat'], 'networkT')
save(['keywords' timenow 'Collaps.mat'], 'allKW')
