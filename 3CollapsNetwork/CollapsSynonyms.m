load('SynonymList.mat');
cellfind = @(string)(@(cell_contents)(strcmp(string,cell_contents)));

for ii=1:length(SynonymList)
    disp(['     - ' num2str(ii) '/' num2str(length(SynonymList)) ': collabs ' SynonymList{ii}{1}]);
    KWidx=[];
    for jj=1:length(SynonymList{ii}) % KW strings to index     
        logical_cells = cellfun(cellfind(SynonymList{ii}{jj}),allKW);
        findthisKW=find(logical_cells==1);
        if length(findthisKW)==1
            KWidx=[KWidx findthisKW];
        end
    end
    if length(KWidx)>1
        KWidx=sort(KWidx,'descend');

        for jj=1:length(KWidx)
            disp(allKW{KWidx(jj)})
        end

        networkTVecNow=networkT(KWidx(end),:);
        disp(['length(KWidx): ' num2str(length(KWidx))])
        for jj=1:length(KWidx)-1   
            networkTVecNow=cellfun(@(a,b)[a b], networkTVecNow, networkT(KWidx(jj),:), 'Uniform', 0);
        end

        for jj=1:length(KWidx)-1
            networkT(KWidx(jj),:)=[];
            networkT(:,KWidx(jj))=[];        

            networkTVecNow(KWidx(jj))=[];
            allKW(KWidx(jj))=[];
        end

        for jj=1:length(networkTVecNow)
            networkTVecNow{jj}=unique(networkTVecNow{jj});
        end
        %nn(KWidx(end),:)=nnVecNew;
        %nn(:,KWidx(end))=nnVecNew';
        %nn(KWidx(end),KWidx(end))=0;

        networkT(KWidx(end),:)=networkTVecNow;
        networkT(:,KWidx(end))=networkTVecNow';
        networkT(KWidx(end),KWidx(end))={[]};

        allKW{KWidx(end)}=SynonymList{ii}{1};
    end
end

nn=cellfun('length',networkT);