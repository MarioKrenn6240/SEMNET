%%%%%%%%%
% Predicting Research Trends with Semantic and Neural Networks with an application in Quantum Physics
% Mario Krenn, Anton Zeilinger
% https://arxiv.org/abs/1906.06843 (in PNAS)
%
% This file is the navigator for creating a semantic network from data,
% and using it for predicting future research trends using artificial
% neural networks.
% 
% The code is far from clean, but should give the principle idea.
% If you have any questions, dont hasitate to contact me:
% mario.krenn@univie.ac.at
%
%
%
% Mario Krenn, Toronto, Canada, 25.12.2019
%
%%%%%%%%%

c=clock;
timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];



% We read abstracts and titles from arxiv files
GetValues
disp('1aCreateFullArticleData')
cd('1aCreateFullArticleData\')
delete('*.mat');
CreateFullArticleData
cd ..

disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');



% We read abstracts and titles from APS data files
GetValues
disp('1bCreateFullArticleData_APS')
cd('1bCreateFullArticleData_APS\')
delete('*.mat');
CreateFullArticleDataAPS
cd ..

disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');




% Using APS + arxiv data, and a keyword list (which we created using
% wikipedia, book indices and RAKE), we create a semantic network
GetValues
disp('2CreateNetwork')
cd('2CreateNetwork\')
delete('*.mat');
copyfile('keywordsList.full','keywordsList.mat')
copyfile(['..\1aCreateFullArticleData\FullArtData' timenow '.mat'],['FullArtData' timenow '.mat']);
for ii=1:2
    copyfile(['..\1bCreateFullArticleData_APS\FullArtDataAPS' timenow '_' num2str(ii) '.mat'],['FullArtDataAPS' timenow '_' num2str(ii) '.mat']);
end
CreateNetwork2


disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');



% We reduce the semantic network to its smallest form, i.e. remove all
% key concepts which are not available in any paper in the dataset
cd ..
GetValues
disp('3CollapsNetwork')
cd('3CollapsNetwork\')
delete('*.mat');
copyfile('keywordsList.full','keywordsList.mat')
copyfile('SynonymList.full','SynonymList.mat')
copyfile(['..\2CreateNetwork\network' timenow '.mat'],['network' timenow '.mat']);
copyfile(['..\2CreateNetwork\networkT' timenow '.mat'],['networkT' timenow '.mat']);
analyseNetwork


disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');



% from the whole semantic network, we create time-slices. i.e. a network
% that has only data until 2010, one that has only data until 2011, ...
cd ..
GetValues
disp('4CalculateAncientNetworks')
cd('4CalculateAncientNetworks\')
delete('*.mat');
copyfile(['..\3CollapsNetwork\network' timenow 'Collaps.mat'],['network' timenow 'Collaps.mat']);
copyfile(['..\3CollapsNetwork\networkT' timenow 'Collaps.mat'],['networkT' timenow 'Collaps.mat']);
copyfile(['..\3CollapsNetwork\keywords' timenow 'Collaps.mat'],['keywords' timenow 'Collaps.mat']);
RemoveBlacklistWords
CreateAncientNetwork
calcAllValuesYearLoop


disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');

% From the collapsed semantic networks, we create training sets for the
% neural network. The training data is for a pair of concepts a vector of
% dimension 17, consisting of network properties of the pair (such as
% cosine-similarity, number of paths of length 2,3,4,...
cd ..
GetValues
disp('5PrepareNNData')
cd('5PrepareNNData\')
delete('*.mat');
[~, ~] = dos('copy ..\4CalculateAncientNetworks\allValues*.mat allValues*.mat');
copyfile('..\4CalculateAncientNetworks\nn201512CutOff.mat','nn201512CutOff.mat');
prepareDataTrain
prepareDataFull

disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');
cd ..



% we use this data to train a neural network predicting whether a certain
% unconnected pair of concepts will be connected in N year (here i set N=3,
% see GetValues.m)
GetValues
disp('6TrainNN')
cd('6TrainNN\')
delete('*.mat');
copyfile('..\5PrepareNNData\TrainData2012.mat','TrainData2012.mat');
copyfile('..\5PrepareNNData\EvalData2015.mat','EvalData2015.mat');
trainNN

disp(' ');
disp(' - - - - - ');
disp(' ');
disp(' ');
cd ..


% we can calculate the ROC and area-under-curve to evaluate the prediction.
% Of course with this small amount of data, the prediction quality is
% extremly bad, close to random.
GetValues
disp('7bCalcROC')
cd('7bCalcROC\')
delete('*.mat');
cosSlimit=0.5;
CalcROC
