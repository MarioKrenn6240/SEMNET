addpath('C:\Users\IQS-1\Dropbox\MetaNetwork\Indizes\jsonlab')
clear all
tic
disp('Loading arxiv directory...');
folder='APS-data\';
JournalDir=dir(folder);
JournalDir(1:2)=[];    % '.' and '..'
toc
disp('Start processing files...');
c=clock;
timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];
%FullArtData=cell(0,7);

for JNi=1:length(JournalDir)
    disp(' ');
    disp(' - - - ');
    disp(' ')
    disp(['Journal: ' JournalDir(JNi).name])
    FullArtDataJN=cell(0,7);
    folder2=[folder JournalDir(JNi).name '\'];
    IssueDir=dir(folder2);
    IssueDir(1:2)=[];
    for IDi=1:length(IssueDir)
        folder3=[folder2 IssueDir(IDi).name '\'];
        ArticleDir=dir(folder3);
        ArticleDir(1:2)=[];        
        FullArtDataAD=cell(0,7);
        for ADi=1:length(ArticleDir)
            FullArtDataNow=cell(1,7);
            FullArtInfos=loadjson([folder3 ArticleDir(ADi).name]);
            if isfield(FullArtInfos,'title') && isfield(FullArtInfos,'abstract') && isfield(FullArtInfos,'date')
                %disp(ArticleDir(ADi).name);
                FullArtDataNow{2}=FullArtInfos.title.value;
                FullArtDataNow{3}=FullArtInfos.abstract.value;
                if isfield(FullArtInfos,'authors')
                    FullArtDataNow{4}=FullArtInfos.authors;
                end
                dateStr=FullArtInfos.date;
                rndidf=66600+floor(rand()*100);
                dateNum=eval([dateStr(1:4) dateStr(6:7) '.' num2str(rndidf)]);
                FullArtDataNow{7}=dateNum;
                FullArtDataAD=[FullArtDataAD; FullArtDataNow];
                %pause(0.1);
            end
        end
        disp(['Issue ' IssueDir(IDi).name ' (' num2str(IDi) '/' num2str(length(IssueDir)) '; ' FullArtInfos.date '): added ' num2str(size(FullArtDataAD,1)) ' articles...']);
        FullArtDataJN=[FullArtDataJN; FullArtDataAD];
    end
    save(['FullArtDataAPS' timenow '_' num2str(JNi) '.mat'],'FullArtDataJN');%'date','title','abstract','allAuthors','allIdentifiers')
    disp('Saved successfully')
    %FullArtData=[FullArtData; FullArtDataJN];
end
c=clock;
timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];
%save(['FullArtDataAPS' num2str(timenow) '.mat'],'FullArtData');%'date','title','abstract','allAuthors','allIdentifiers')
