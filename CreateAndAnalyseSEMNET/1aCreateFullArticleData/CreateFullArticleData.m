clear all
tic
disp('Loading arxiv directory...');
folder='arxivAbstractsXML\';
absDir=dir(folder);
absDir(1:2)=[];    % '.' and '..'
toc
    disp('Start processing files...');
    %FullArtData=cell(length(absDir),5);
    NumOfArticles=length(absDir);
    FullArtData=cell(NumOfArticles,5);
tic

for files=1:NumOfArticles
    %disp(['Process ' absDir(files).name]);
    fnArt=[folder absDir(files).name];
    %[date{files},title{files},abstract{files},allAuthors{files},allIdentifiers{files}]=XML2ArticleData(fnArt);
    [FullArtData{files,1},FullArtData{files,2},FullArtData{files,3},FullArtData{files,4},FullArtData{files,5}]=XML2ArticleData(fnArt);

    FullArtData{files,6}=fnArt;
    FullArtData{files,7}=Absfname2number(absDir(files).name);%identifies article yyyymm.####

    if(mod(files,1000)==0)
        toc
        disp(['Processing file: ' num2str(files) '/' num2str(length(absDir)) '=' num2str(files/length(absDir))]);
        tic
    end
end

c=clock;
timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];
%save(['alles' num2str(timenow) '.mat'],'date','title','abstract','allAuthors','allIdentifiers')
save(['FullArtData' num2str(timenow) '.mat'],'FullArtData');%'date','title','abstract','allAuthors','allIdentifiers')
