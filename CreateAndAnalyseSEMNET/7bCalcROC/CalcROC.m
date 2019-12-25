close all
run('..\GetValues.m')
for cROCii=1:length(yearlimits)-2*PredictionInterval-2
    disp(['Calculate the ROC and AUC with ' num2str(yearlimits(cROCii)-2*PredictionInterval) ' data (' num2str(yearlimits(cROCii)-PredictionInterval) ' network) for ' num2str(yearlimits(cROCii))]);
    load(['..\6TrainNN\TrainedNet' num2str(yearlimits(cROCii)-PredictionInterval) '.mat']);
    load(['..\5PrepareNNData\EvalData' num2str(yearlimits(cROCii)-PredictionInterval) '.mat']);

    % !!!!!!!!!!!!!
                %Pr(6:17,:)=0;
                %Pr(3:4,:)=0;

    [Yr,Pf,Af,E,perf] = sim(net,Pr);

    [val,idx]=sort(Yr,'descend'); % Sortierte predictions
    TrSort=Tr(idx(:));       % znewSort
    meanData=mean(Tr);

    NNN=length(val);
    xtotal=sum(TrSort(1:NNN)<meanData);
    ytotal=sum(TrSort(1:NNN)>meanData);

    ROCvals=[];
    ROC=zeros([1,NNN]);
    xpos=0;
    ypos=0;

    for ii=1:NNN
        %if mod(ii,1000000)==0
        %    disp([num2str(ii) '/' num2str(NNN)]);
        %end
        if TrSort(ii)>meanData
            ROC(ii)=1;
            xpos(end+1)=xpos(end);
            ypos(end+1)=ypos(end)+(1/ytotal);
        else
            ROC(ii)=0;
            xpos(end+1)=xpos(end)+(1/xtotal);
            ypos(end+1)=ypos(end);
            ROCvals(end+1)=ypos(end);
        end
    end

    AUC=sum(ROCvals)/length(ROCvals);

    xpos(end+1)=1;
    ypos(end+1)=1;

    figure(1)
    plot(xpos,ypos)
    title(['ROC for ' num2str(yearlimits(cROCii)) ' (with ' num2str(yearlimits(cROCii)-PredictionInterval) ' network) (AUC=' num2str(AUC) ')'])
    axis([0,1,0,1])
    disp(['Area under curve for ' num2str(yearlimits(cROCii)) ' (with ' num2str(yearlimits(cROCii)) ' network): ' num2str(AUC)]);
    pause(0.1);   
    saveas(1,['ROC_PI' num2str(PredictionInterval) '_Y' num2str(yearlimits(cROCii)) '_' num2str(OverallNum) '.png'],'png');
    pause(0.1);
    fID=fopen(['ROC_' num2str(PredictionInterval) 'years_' num2str(OverallNum) '.txt'],'a+');    
    fwrite(fID, [',{' num2str(yearlimits(cROCii)) ',' num2str(AUC) '}']);
    fclose(fID);
end