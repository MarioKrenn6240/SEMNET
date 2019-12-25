% ReadMyAbstracts

abstract = fileread('AllMyAbstracts.txt');
abstract=strrep(abstract,char(39),''); % ' removed
abstract=strrep(abstract,'--','-');    % -- to -
abstract=strrep(abstract,'-',' ');     % - to <space>
abstract=strrep(abstract,'ö','oe');
abstract=strrep(abstract,'ä','ae');
abstract=strrep(abstract,'ü','ue');
abstract=strrep(abstract,'{\"o}','oe');
abstract=strrep(abstract,'\''','');
abstract=lower(abstract);
