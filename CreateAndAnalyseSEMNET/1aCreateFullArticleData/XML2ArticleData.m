function [date,title,abstract,allAuthors,allIdentifiers]=XML2ArticleData(fnArt)
%datum, title, abstract, alle autoren, alleIdentifier(Journals)


fID2=fopen(fnArt, 'r'); dlines2={fgetl(fID2)};
while ischar(dlines2{end})
    curLine2=fgetl(fID2);
    dlines2{end+1}=curLine2;
end
fclose(fID2);
dlines2=strjoin(dlines2,' ');

titStart=strfind(dlines2,'<dc:title>');
titEnd=strfind(dlines2,'</dc:title>');
title=dlines2(titStart(1)+10:titEnd(1)-1);

absStart=strfind(dlines2,'<dc:description>');
absEnd=strfind(dlines2,'</dc:description>');
abstract=dlines2(absStart(1)+17:absEnd(1)-1);


datStart=strfind(dlines2,'<dc:date>');
datEnd=strfind(dlines2,'</dc:date>'); 
datStr=dlines2(datStart(1)+9:datEnd(1)-1);
date=datenum(datStr);

authStart=strfind(dlines2,'<dc:creator>');
authEnd=strfind(dlines2,'</dc:creator>');
allAuthors=cell(numel(authStart),1);
for authors=1:numel(authStart)
    auth=dlines2(authStart(authors)+12:authEnd(authors)-1);
    allAuthors{authors}=auth;
end

idStart=strfind(dlines2,'<dc:identifier>');
idEnd=strfind(dlines2,'</dc:identifier>');
allIdentifiers=cell(numel(idStart),1);
for ide=1:numel(idStart)
    identi=dlines2(idStart(ide)+15:idEnd(ide)-1);
    allIdentifiers{ide}=identi;
end


%disp(abstract);
%pause(1);