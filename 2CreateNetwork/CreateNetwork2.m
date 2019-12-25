clear all

load('keywordsList.mat');
disp(['Generating Network - (#KW=' num2str(length(allKW)) ')'])

networkT=cell(length(allKW));
szAbs=[];
CalculateSortedallKW
padding='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

DataMat=dir('FullArtData*.mat');

for ArtIdx=1:length(DataMat)
    disp(['Loading ' DataMat(ArtIdx).name]);

    load(DataMat(ArtIdx).name)
    disp(['Analysing ' DataMat(ArtIdx).name ' with ' num2str(size(FullArtData,1)) ' articles...']);
    allTitles=FullArtData(:,2);
    allAbstracts=FullArtData(:,3);

    for article=1:length(allAbstracts)
        % Prepare the abstract
        abstract=[allTitles{article} ' ' allAbstracts{article}];
        abstract=strrep(abstract,char(39),''); % ' removed
        abstract=strrep(abstract,'--','-');    % -- to -
        abstract=strrep(abstract,'-',' ');     % - to <space>
        abstract=strrep(abstract,'ö','oe');
        abstract=strrep(abstract,'ä','ae');
        abstract=strrep(abstract,'ü','ue');
        abstract=strrep(abstract,'{\"o}','oe');
        abstract=strrep(abstract,'\''','');
        abstract=lower(abstract);


        % Remove brakets, for example: Clauser-Horne (CH) inequality.
        klammerauf=strfind(abstract,'(');
        klammerzu=strfind(abstract,')');
        removeklammer=0;
        if length(klammerauf)==length(klammerzu)&&~isempty(klammerauf)
            removeklammer=1;
            for ii=1:length(klammerauf)-1 % nested brackets
                if klammerauf(ii+1)<klammerzu(ii)
                    removeklammer=0;
                end
            end
        end
        if removeklammer==1
            klammerauf=[klammerauf-1 length(abstract)];
            klammerzu=[1 klammerzu+1];
            abstractNoBrakets=[];
            for ii=1:length(klammerauf)
                abstractNoBrakets=[abstractNoBrakets abstract(klammerzu(ii):klammerauf(ii))];
            end
            abstractNoBrakets=strrep(abstractNoBrakets,'  ',' ');
        end     


        % Find KWs in full abstract    
        foundKW=[];
        for i=1:length(allKW)
            kidx=strfind(abstract,allKW{allKWsortedIdx(i)});
            if ~isempty(kidx)
               %disp(['Found: ' allKW{i} ' (' num2str(i) ')'])
                foundKW=[foundKW allKWsortedIdx(i)]; % delete duplicates!!

                lenkw=length(allKW{allKWsortedIdx(i)});        
                for j=1:length(kidx)
                    abstract(kidx(j):(kidx(j)+lenkw-1))=padding(1:lenkw); % remove this word from abstract, such that smaller words do not use same again
                end
            end
        end


        % Find KWs in bracket-removed abstract
        if removeklammer==1
            for i=1:length(allKW)
                kidx=strfind(abstractNoBrakets,allKW{allKWsortedIdx(i)});
                if ~isempty(kidx)
                   %disp(['Found: ' allKW{i} ' (' num2str(i) ')'])
                    foundKW=[foundKW allKWsortedIdx(i)]; % delete duplicates!!

                    lenkw=length(allKW{allKWsortedIdx(i)});        
                    for j=1:length(kidx)
                        abstractNoBrakets(kidx(j):(kidx(j)+lenkw-1))=padding(1:lenkw); % remove this word from abstract, such that smaller words do not use same again
                    end
                end
            end
            foundKW=unique(foundKW);
        end    


        % Include information into network
        for i=1:(length(foundKW)-1)
            for j=i+1:length(foundKW)
                %nn(foundKW(i),foundKW(j))=nn(foundKW(i),foundKW(j))+1;
                networkT{foundKW(i),foundKW(j)}=[networkT{foundKW(i),foundKW(j)} FullArtData{article,7}];
                networkT{foundKW(j),foundKW(i)}=[networkT{foundKW(j),foundKW(i)} FullArtData{article,7}];            
            end
        end

        if(mod(article,1000)==0)
            toc
            disp(['Processing article: ' num2str(article) '/' num2str(length(allAbstracts)) '=' num2str(article/length(allAbstracts))]);
            tic
        end
    end
end

nn=cellfun('length',networkT);

c=clock;
timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];
save(['network' timenow '.mat'], 'nn')
save(['networkT' timenow '.mat'], 'networkT')
