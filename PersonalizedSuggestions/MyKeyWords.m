% MyKeyWords
clear all
load('allKW201712Collaps_Deg0Removed.mat')
load('nums2017.mat')
CalculateSortedallKW
padding='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';

ReadMyAbstracts

% Remove brakets, for example: Clauser-Horne (CH) inequality.
klammerauf=strfind(abstract,'(');
klammerzu=strfind(abstract,')');
removeklammer=0;
if length(klammerauf)==length(klammerzu)&&~isempty(klammerauf)
    removeklammer=1;
    for ii=1:length(klammerauf)-1 % verschachtelte klammern ignorieren wir
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
    %foundKW=unique(foundKW);
end    

ReadMyAbstracts
foundKW=unique(foundKW);

NumOfTimes=[];
NumOfPapers=[];
allKWidx=[];
for ii=1:length(foundKW)
    NumOfTimes(end+1)=length(strfind(abstract,allKW{foundKW(ii)}));
    NumOfPapers(end+1)=nums201712(foundKW(ii));
    allKWidx(end+1)=foundKW(ii);
end

pScientist=NumOfTimes/sum(NumOfTimes);
pTotal=NumOfPapers/sum(nums201712);
ratioTimesOverPapers=pScientist./pTotal;

[val,idx]=sort(ratioTimesOverPapers,'descend');
AboveList=[];
for ii=1:length(idx)
    if strcmp(allKW{allKWidx(idx(ii))},'s knot')==0 && strcmp(allKW{allKWidx(idx(ii))},'richard feynman')==0 && strcmp(allKW{allKWidx(idx(ii))},'john bell')==0
        if true %ratioTimesOverPapers(idx(ii))>0.0128
            if ratioTimesOverPapers(idx(ii))>1
                AboveList(end+1)=allKWidx(idx(ii));
            end
            disp([num2str(ii) ': ' allKW{allKWidx(idx(ii))} ': ' num2str(ratioTimesOverPapers(idx(ii))) ' (' num2str(NumOfTimes(idx(ii))) '/' num2str(NumOfPapers(idx(ii))) ')' ])        
        end
    end
end


MyGoodKWList=AboveList;
ApplyToFutureANL