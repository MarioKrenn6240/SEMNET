clear all
run('..\GetValues.m')

for pDTii=1:(length(yearlimits)-PredictionInterval-2)
    calcYearTrain=yearlimits(pDTii)-PredictionInterval; % Data up to 2009
    calcYearTrainFin=yearlimits(pDTii); % learning 2012
    disp(['Prepare Training data from ' num2str(yearlimits(pDTii)) ' to predict ' num2str(yearlimits(pDTii)+PredictionInterval)]);

    disp(['    Load ' num2str(calcYearTrain) '.']);
    load(['..\4CalculateAncientNetworks\allValues' num2str(calcYearTrain) '12.mat'])
    cosSY1=eval(['cosS' num2str(calcYearTrain) '12']); eval(['clear cosS' num2str(calcYearTrain) '12']);
    degreeY1=eval(['degree' num2str(calcYearTrain) '12']); eval(['clear degree' num2str(calcYearTrain) '12']);
    distanceY1=eval(['distance' num2str(calcYearTrain) '12']); eval(['clear distance' num2str(calcYearTrain) '12']);
    distanceAlt1Y1=eval(['distanceAlt1' num2str(calcYearTrain) '12']); eval(['clear distanceAlt1' num2str(calcYearTrain) '12']);
    distanceAlt2Y1=eval(['distanceAlt2' num2str(calcYearTrain) '12']); eval(['clear distanceAlt2' num2str(calcYearTrain) '12']);
    nnY1=eval(['nn' num2str(calcYearTrain) '12']); eval(['clear nn' num2str(calcYearTrain) '12']);
    numsY1=eval(['nums' num2str(calcYearTrain) '12']); eval(['clear nums' num2str(calcYearTrain) '12']);
    paths2Y1=eval(['paths2' num2str(calcYearTrain) '12']); eval(['clear paths2' num2str(calcYearTrain) '12']);
    paths3Y1=eval(['paths3' num2str(calcYearTrain) '12']); eval(['clear paths3' num2str(calcYearTrain) '12']);
    paths4Y1=eval(['paths4' num2str(calcYearTrain) '12']); eval(['clear paths4' num2str(calcYearTrain) '12']);
    paths5Y1=eval(['paths5' num2str(calcYearTrain) '12']); eval(['clear paths5' num2str(calcYearTrain) '12']);
    paths2Y1=paths2Y1/max(max(paths2Y1));
    paths3Y1=paths3Y1/max(max(paths3Y1));
    paths4Y1=paths4Y1/max(max(paths4Y1));
    paths5Y1=paths5Y1/max(max(paths5Y1));

    disp(['    Load ' num2str(calcYearTrain-1) '.']);
    load(['..\4CalculateAncientNetworks\allValues' num2str(calcYearTrain-1) '12.mat'])
    cosSY2=eval(['cosS' num2str(calcYearTrain-1) '12']); eval(['clear cosS' num2str(calcYearTrain-1) '12']);
    degreeY2=eval(['degree' num2str(calcYearTrain-1) '12']); eval(['clear degree' num2str(calcYearTrain-1) '12']);
    distanceY2=eval(['distance' num2str(calcYearTrain-1) '12']); eval(['clear distance' num2str(calcYearTrain-1) '12']);
    distanceAlt1Y2=eval(['distanceAlt1' num2str(calcYearTrain-1) '12']); eval(['clear distanceAlt1' num2str(calcYearTrain-1) '12']);
    distanceAlt2Y2=eval(['distanceAlt2' num2str(calcYearTrain-1) '12']); eval(['clear distanceAlt2' num2str(calcYearTrain-1) '12']);
    nnY2=eval(['nn' num2str(calcYearTrain-1) '12']); eval(['clear nn' num2str(calcYearTrain-1) '12']);
    numsY2=eval(['nums' num2str(calcYearTrain-1) '12']); eval(['clear nums' num2str(calcYearTrain-1) '12']);
    paths2Y2=eval(['paths2' num2str(calcYearTrain-1) '12']); eval(['clear paths2' num2str(calcYearTrain-1) '12']);
    paths3Y2=eval(['paths3' num2str(calcYearTrain-1) '12']); eval(['clear paths3' num2str(calcYearTrain-1) '12']);
    paths4Y2=eval(['paths4' num2str(calcYearTrain-1) '12']); eval(['clear paths4' num2str(calcYearTrain-1) '12']);
    paths5Y2=eval(['paths5' num2str(calcYearTrain-1) '12']); eval(['clear paths5' num2str(calcYearTrain-1) '12']);
    paths2Y2=paths2Y2/max(max(paths2Y2));
    paths3Y2=paths3Y2/max(max(paths3Y2));
    paths4Y2=paths4Y2/max(max(paths4Y2));
    paths5Y2=paths5Y2/max(max(paths5Y2));

    disp(['    Load ' num2str(calcYearTrain-2) '.']);    
    load(['..\4CalculateAncientNetworks\allValues' num2str(calcYearTrain-2) '12.mat'])
    cosSY3=eval(['cosS' num2str(calcYearTrain-2) '12']); eval(['clear cosS' num2str(calcYearTrain-2) '12']);
    degreeY3=eval(['degree' num2str(calcYearTrain-2) '12']); eval(['clear degree' num2str(calcYearTrain-2) '12']);
    distanceY3=eval(['distance' num2str(calcYearTrain-2) '12']); eval(['clear distance' num2str(calcYearTrain-2) '12']);
    distanceAlt1Y3=eval(['distanceAlt1' num2str(calcYearTrain-2) '12']); eval(['clear distanceAlt1' num2str(calcYearTrain-2) '12']);
    distanceAlt2Y3=eval(['distanceAlt2' num2str(calcYearTrain-2) '12']); eval(['clear distanceAlt2' num2str(calcYearTrain-2) '12']);
    nnY3=eval(['nn' num2str(calcYearTrain-2) '12']); eval(['clear nn' num2str(calcYearTrain-2) '12']);
    numsY3=eval(['nums' num2str(calcYearTrain-2) '12']); eval(['clear nums' num2str(calcYearTrain-2) '12']);
    paths2Y3=eval(['paths2' num2str(calcYearTrain-2) '12']); eval(['clear paths2' num2str(calcYearTrain-2) '12']);
    paths3Y3=eval(['paths3' num2str(calcYearTrain-2) '12']); eval(['clear paths3' num2str(calcYearTrain-2) '12']);
    paths4Y3=eval(['paths4' num2str(calcYearTrain-2) '12']); eval(['clear paths4' num2str(calcYearTrain-2) '12']);
    paths5Y3=eval(['paths5' num2str(calcYearTrain-2) '12']); eval(['clear paths5' num2str(calcYearTrain-2) '12']);
    paths2Y3=paths2Y3/max(max(paths2Y3));
    paths3Y3=paths3Y3/max(max(paths3Y3));
    paths4Y3=paths4Y3/max(max(paths4Y3));
    paths5Y3=paths5Y3/max(max(paths5Y3));
    
    load(['..\4CalculateAncientNetworks\nn' num2str(calcYearTrainFin) '12CutOff.mat']);
    nnFin=eval(['nn' num2str(calcYearTrainFin) '12']);

    degVec=double(numsY1>5);              % deg201212>3
    degMat=(degVec')*degVec;
    %HighValues1=triu((nnY1<=5).*((nnFin-nnY1)>=2).*degMat.*distanceY1); 
    %HighValues2=triu((nnY1<=3).*((nnFin-nnY1)>=2).*degMat.*distanceY1);
    %HighValues3=triu((nnY1<=2).*((nnFin-nnY1)>=1).*degMat.*distanceY1); 
    %HighValues=HighValues1+HighValues2+HighValues3;
    HighValues=triu((nnY1==0).*((nnFin-nnY1)>=1).*degMat.*distanceY1); 
    HIidx=find(HighValues); [HIidx_row, HIidx_col] = ind2sub(size(HighValues),HIidx);

    RandomValues=triu((nnY1==0).*degMat.*distanceY1);
    RDidx=find(RandomValues); [RDidx_rowF, RDidx_colF] = ind2sub(size(RandomValues),RDidx);

    randSelection=randi(length(RDidx_rowF),[1,round(3*length(HIidx))]);
    RDidx_row=RDidx_rowF(randSelection);
    RDidx_col=RDidx_colF(randSelection);

    ALLidx_row=[HIidx_row' RDidx_row'];
    ALLidx_col=[HIidx_col' RDidx_col'];

    % Calculate actual result
    tResAll=zeros([1,length(ALLidx_row)]);

    tnn12=zeros([1,length(ALLidx_row)]);
    tnn11=zeros([1,length(ALLidx_row)]);
    tnn10=zeros([1,length(ALLidx_row)]);
    tcosS12=zeros([1,length(ALLidx_row)]);
    tpaths212=zeros([1,length(ALLidx_row)]);
    tpaths211=zeros([1,length(ALLidx_row)]);
    tpaths210=zeros([1,length(ALLidx_row)]);
    tpaths312=zeros([1,length(ALLidx_row)]);
    tpaths311=zeros([1,length(ALLidx_row)]);
    tpaths310=zeros([1,length(ALLidx_row)]);
    tpaths412=zeros([1,length(ALLidx_row)]);
    tpaths411=zeros([1,length(ALLidx_row)]);
    tpaths410=zeros([1,length(ALLidx_row)]);
    tpaths512=zeros([1,length(ALLidx_row)]);
    tpaths511=zeros([1,length(ALLidx_row)]);
    tpaths510=zeros([1,length(ALLidx_row)]);

    tdegA12=zeros([1,length(ALLidx_row)]);
    tdegB12=zeros([1,length(ALLidx_row)]);
    tnumsA12=zeros([1,length(ALLidx_row)]);
    tnumsB12=zeros([1,length(ALLidx_row)]);
    tbtwcEA12=zeros([1,length(ALLidx_row)]);
    tbtwcEB12=zeros([1,length(ALLidx_row)]);

    tdist12=zeros([1,length(ALLidx_row)]);
    tdistAlt112=zeros([1,length(ALLidx_row)]);
    tdistAlt212=zeros([1,length(ALLidx_row)]);

    degreeY1=degreeY1/max(degreeY1(:));
    numsY1=numsY1/max(numsY1(:));
    
    KW1all=zeros([1,length(ALLidx_row)]);
    KW2all=zeros([1,length(ALLidx_row)]);

    for ii=1:length(ALLidx_row)
        KW1=ALLidx_row(ii);
        KW2=ALLidx_col(ii);
        if degreeY1(KW2)>degreeY1(KW1)
            tmp=KW1;
            KW1=KW2;
            KW2=tmp;
        end

        tResAll(ii)=nnFin(KW1,KW2)-nnY1(KW1,KW2);

        tnn12(ii)=nnY1(KW1,KW2);
        tnn11(ii)=nnY2(KW1,KW2);
        tnn10(ii)=nnY3(KW1,KW2);

        tdegA12(ii)=degreeY1(KW1);
        tdegB12(ii)=degreeY1(KW2);

        tnumsA12(ii)=numsY1(KW1);
        tnumsB12(ii)=numsY1(KW2);

    %    tbtwcEA12(ii)=btwcEY1(KW1);
    %    tbtwcEB12(ii)=btwcEY1(KW2);

        tcosS12(ii)=cosSY1(KW1,KW2);

        tpaths212(ii)=paths2Y1(KW1,KW2);
        tpaths211(ii)=paths2Y2(KW1,KW2);
        tpaths210(ii)=paths2Y3(KW1,KW2);
        tpaths312(ii)=paths3Y1(KW1,KW2);
        tpaths311(ii)=paths3Y2(KW1,KW2);
        tpaths310(ii)=paths3Y3(KW1,KW2);
        tpaths412(ii)=paths4Y1(KW1,KW2);
        tpaths411(ii)=paths4Y2(KW1,KW2);
        tpaths410(ii)=paths4Y3(KW1,KW2);
        tpaths512(ii)=paths5Y1(KW1,KW2);
        tpaths511(ii)=paths5Y2(KW1,KW2);
        tpaths510(ii)=paths5Y3(KW1,KW2);    

        tdist12(ii)=distanceY1(KW1,KW2);
        tdistAlt112(ii)=distanceAlt1Y1(KW1,KW2);
        tdistAlt212(ii)=distanceAlt2Y1(KW1,KW2);    
        
        KW1all(ii)=KW1;
        KW2all(ii)=KW2;
    end

    tpaths212=tpaths212/max(tpaths212);
    tpaths211=tpaths211/max(tpaths211);
    tpaths210=tpaths210/max(tpaths210);
    tpaths312=tpaths312/max(tpaths312);
    tpaths311=tpaths311/max(tpaths311);
    tpaths310=tpaths310/max(tpaths310);
    tpaths412=tpaths412/max(tpaths412);
    tpaths411=tpaths411/max(tpaths411);
    tpaths410=tpaths410/max(tpaths410);

    tdistAlt112=tdistAlt112/max(tdistAlt112);
    tdistAlt212=tdistAlt212/max(tdistAlt212);

    P=[tdegA12;tdegB12; ...
        tnumsA12;tnumsB12;tcosS12; ...
        tpaths212;tpaths211;tpaths210;tpaths312;tpaths311;tpaths310;tpaths412;tpaths411;tpaths410; ...
        tdist12;tdistAlt112;tdistAlt212];
    
    T=tResAll;

    save(['TrainData' num2str(calcYearTrain) '.mat'],'P','T')
end