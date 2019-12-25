%clear all
c=clock;
%timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];


disp('RemoveBlacklistWords')
disp('load keywords and networkT')

load(['..\3CollapsNetwork\keywords' timenow 'Collaps.mat']);
load(['..\3CollapsNetwork\networkT' timenow 'Collaps.mat']);

% mainly very large and general words
disp('Calculate nums of 2015')
numsT=cell([1,length(networkT)]);
for ii=1:length(networkT)
    numsT{ii}=unique(horzcat(networkT{ii,:}));
end
nums2015=cellfun('length',numsT);

disp('Remove nums>=100000 of 2015')
RemoveLargeIdx=(nums2015<100000);
networkT=networkT(RemoveLargeIdx,RemoveLargeIdx);
allKW=allKW(RemoveLargeIdx);

nnFull=cellfun('length',networkT);
degreeFull=sum(nnFull>0);
RemoveLargeIdx2=(degreeFull<100000);
networkT=networkT(RemoveLargeIdx2,RemoveLargeIdx2);
allKW=allKW(RemoveLargeIdx2);

