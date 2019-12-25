disp('Remove deg(KW)=0 in nnCutoff')
load(['nn' num2str(yearlimits(1)) '12Collaps.mat'])
nnCutOff=nnAncient;
degNow=sum(nnCutOff>0);
allKW=allKW(degNow>0);

save(['allKW' num2str(yearlimits(1)) '12Collaps_Deg0Removed.mat'],'allKW');

disp(['yearlimits: ' num2str(yearlimits)]);

for ii=1:length(yearlimits)
    disp(['Calcualte all Values for ' num2str(yearlimits(ii))]);
    load(['nn' num2str(yearlimits(ii)) '12Collaps.mat'])
    nnAncient=nnAncient(degNow>0,:); nnAncient=nnAncient(:,degNow>0); numsAncient=numsAncient(degNow>0);
    calcAllValuesOptimized3
    eval(['nn' num2str(yearlimits(ii)) '12=nnAncient;']);
    save(['nn' num2str(yearlimits(ii)) '12CutOff.mat'],['nn' num2str(yearlimits(ii)) '12']);
    eval(['nums' num2str(yearlimits(ii)) '12=numsAncient;']);
    eval(['degree' num2str(yearlimits(ii)) '12=degreeAncient;']);
    %eval(['btwcE' num2str(yearlimits(ii)) '=btwcEAncient;']);
    eval(['distance' num2str(yearlimits(ii)) '12=distanceAncient;']);
    eval(['distanceAlt1' num2str(yearlimits(ii)) '12=distanceAlt1Ancient;']);
    eval(['distanceAlt2' num2str(yearlimits(ii)) '12=distanceAlt2Ancient;']);
    eval(['cosS' num2str(yearlimits(ii)) '12=cosSAncient;']);
    eval(['paths2' num2str(yearlimits(ii)) '12=paths2Ancient;']);
    eval(['paths3' num2str(yearlimits(ii)) '12=paths3Ancient;']);
    eval(['paths4' num2str(yearlimits(ii)) '12=paths4Ancient;']);
    eval(['paths5' num2str(yearlimits(ii)) '12=paths5Ancient;']);    

    save(['allValues' num2str(yearlimits(ii)) '12.mat'], ...
        ['nn' num2str(yearlimits(ii)) '12'], ['nums' num2str(yearlimits(ii)) '12'], ...
        ['degree' num2str(yearlimits(ii)) '12'], ['distance' num2str(yearlimits(ii)) '12'], ...
        ['distanceAlt1' num2str(yearlimits(ii)) '12'], ['distanceAlt2' num2str(yearlimits(ii)) '12'], ...
        ['cosS' num2str(yearlimits(ii)) '12'], ['paths2' num2str(yearlimits(ii)) '12'], ...
        ['paths3' num2str(yearlimits(ii)) '12'], ['paths4' num2str(yearlimits(ii)) '12'], ... 
        ['paths5' num2str(yearlimits(ii)) '12']);

    eval(['clear degree' num2str(yearlimits(ii)) '12']);
    %eval(['clear btwcE' num2str(yearlimits(ii))]);
    eval(['clear distance' num2str(yearlimits(ii)) '12']);
    eval(['clear distanceAlt1' num2str(yearlimits(ii)) '12']);
    eval(['clear distanceAlt2' num2str(yearlimits(ii)) '12']);    
    eval(['clear cosS' num2str(yearlimits(ii)) '12']);
    eval(['clear paths2' num2str(yearlimits(ii)) '12']);
    eval(['clear paths3' num2str(yearlimits(ii)) '12']);
    eval(['clear paths4' num2str(yearlimits(ii)) '12']);
    eval(['clear paths5' num2str(yearlimits(ii)) '12']);
end

