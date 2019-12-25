papercode=200105.66607;
concept1='boson';
concept2='optical lattice';
found=0;
for ii=1:17
    disp(['ii: ' num2str(ii)]);
    load(['FullArtDataAPS201831_' num2str(ii)])
    
    for jj=1:length(FullArtDataJN)
        if FullArtDataJN{jj,7}==papercode
            if (~isempty(strfind(FullArtDataJN{jj,2},concept1)) || ~isempty(strfind(FullArtDataJN{jj,3},concept1))) && ...
                    (~isempty(strfind(FullArtDataJN{jj,2},concept2)) || ~isempty(strfind(FullArtDataJN{jj,3},concept2))) 
                disp(['FOUND: ' num2str(jj)]);
                found=1;
                disp(FullArtDataJN{jj,2});
                break;
            end
        end
    end
    if found==1
        break;
    end
end