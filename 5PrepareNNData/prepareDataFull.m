clear all
run('..\GetValues.m')

for pDFii=1:length(yearlimits)-2
    calcYearEval=yearlimits(pDFii);
    calcYearEvalFin=yearlimits(pDFii)+PredictionInterval;
    disp(['Prepare Full data from ' num2str(yearlimits(pDFii)) ' to predict ' num2str(yearlimits(pDFii)+PredictionInterval)]);
    load(['..\4CalculateAncientNetworks\allValues' num2str(calcYearEval) '12.mat'])
    cosSY1=eval(['cosS' num2str(calcYearEval) '12']); eval(['clear cosS' num2str(calcYearEval) '12']);
    degreeY1=eval(['degree' num2str(calcYearEval) '12']); eval(['clear degree' num2str(calcYearEval) '12']);
    distanceY1=eval(['distance' num2str(calcYearEval) '12']); eval(['clear distance' num2str(calcYearEval) '12']);
    distanceAlt1Y1=eval(['distanceAlt1' num2str(calcYearEval) '12']); eval(['clear distanceAlt1' num2str(calcYearEval) '12']);
    distanceAlt2Y1=eval(['distanceAlt2' num2str(calcYearEval) '12']); eval(['clear distanceAlt2' num2str(calcYearEval) '12']);
    nnY1=eval(['nn' num2str(calcYearEval) '12']); eval(['clear nn' num2str(calcYearEval) '12']);
    numsY1=eval(['nums' num2str(calcYearEval) '12']); eval(['clear nums' num2str(calcYearEval) '12']);
    paths2Y1=eval(['paths2' num2str(calcYearEval) '12']); eval(['clear paths2' num2str(calcYearEval) '12']);
    paths3Y1=eval(['paths3' num2str(calcYearEval) '12']); eval(['clear paths3' num2str(calcYearEval) '12']);
    paths4Y1=eval(['paths4' num2str(calcYearEval) '12']); eval(['clear paths4' num2str(calcYearEval) '12']);
    paths5Y1=eval(['paths5' num2str(calcYearEval) '12']); eval(['clear paths5' num2str(calcYearEval) '12']);

    load(['..\4CalculateAncientNetworks\allValues' num2str(calcYearEval-1) '12.mat'])
    cosSY2=eval(['cosS' num2str(calcYearEval-1) '12']); eval(['clear cosS' num2str(calcYearEval-1) '12']);
    degreeY2=eval(['degree' num2str(calcYearEval-1) '12']); eval(['clear degree' num2str(calcYearEval-1) '12']);
    distanceY2=eval(['distance' num2str(calcYearEval-1) '12']); eval(['clear distance' num2str(calcYearEval-1) '12']);
    distanceAlt1Y2=eval(['distanceAlt1' num2str(calcYearEval-1) '12']); eval(['clear distanceAlt1' num2str(calcYearEval-1) '12']);
    distanceAlt2Y2=eval(['distanceAlt2' num2str(calcYearEval-1) '12']); eval(['clear distanceAlt2' num2str(calcYearEval-1) '12']);
    nnY2=eval(['nn' num2str(calcYearEval-1) '12']); eval(['clear nn' num2str(calcYearEval-1) '12']);
    numsY2=eval(['nums' num2str(calcYearEval-1) '12']); eval(['clear nums' num2str(calcYearEval-1) '12']);
    paths2Y2=eval(['paths2' num2str(calcYearEval-1) '12']); eval(['clear paths2' num2str(calcYearEval-1) '12']);
    paths3Y2=eval(['paths3' num2str(calcYearEval-1) '12']); eval(['clear paths3' num2str(calcYearEval-1) '12']);
    paths4Y2=eval(['paths4' num2str(calcYearEval-1) '12']); eval(['clear paths4' num2str(calcYearEval-1) '12']);
    paths5Y2=eval(['paths5' num2str(calcYearEval-1) '12']); eval(['clear paths5' num2str(calcYearEval-1) '12']);
    
    load(['..\4CalculateAncientNetworks\allValues' num2str(calcYearEval-2) '12.mat'])
    cosSY3=eval(['cosS' num2str(calcYearEval-2) '12']); eval(['clear cosS' num2str(calcYearEval-2) '12']);
    degreeY3=eval(['degree' num2str(calcYearEval-2) '12']); eval(['clear degree' num2str(calcYearEval-2) '12']);
    distanceY3=eval(['distance' num2str(calcYearEval-2) '12']); eval(['clear distance' num2str(calcYearEval-2) '12']);
    distanceAlt1Y3=eval(['distanceAlt1' num2str(calcYearEval-2) '12']); eval(['clear distanceAlt1' num2str(calcYearEval-2) '12']);
    distanceAlt2Y3=eval(['distanceAlt2' num2str(calcYearEval-2) '12']); eval(['clear distanceAlt2' num2str(calcYearEval-2) '12']);
    nnY3=eval(['nn' num2str(calcYearEval-2) '12']); eval(['clear nn' num2str(calcYearEval-2) '12']);
    numsY3=eval(['nums' num2str(calcYearEval-2) '12']); eval(['clear nums' num2str(calcYearEval-2) '12']);
    paths2Y3=eval(['paths2' num2str(calcYearEval-2) '12']); eval(['clear paths2' num2str(calcYearEval-2) '12']);
    paths3Y3=eval(['paths3' num2str(calcYearEval-2) '12']); eval(['clear paths3' num2str(calcYearEval-2) '12']);
    paths4Y3=eval(['paths4' num2str(calcYearEval-2) '12']); eval(['clear paths4' num2str(calcYearEval-2) '12']);
    paths5Y3=eval(['paths5' num2str(calcYearEval-2) '12']); eval(['clear paths5' num2str(calcYearEval-2) '12']);

    nnFin=nnY1; % if it doesnt exist, tResAll will be zero
    if exist(['..\4CalculateAncientNetworks\nn' num2str(calcYearEvalFin) '12CutOff.mat'],'file')
        load(['..\4CalculateAncientNetworks\nn' num2str(calcYearEvalFin) '12CutOff.mat']);
        nnFin=eval(['nn' num2str(calcYearEvalFin) '12']);
    end
    disp('Difference: ');
    disp(sum(sum(nnFin-nnY1)));
    
    %random seed
    rng('shuffle')

    degVec=double(numsY1>5);              % deg201212>3
    degMat=(degVec')*degVec;
    AllValues1=triu(degMat.*(nnY1==0).*(1-eye(length(degMat))));
    Allidx=find(AllValues1);
    [ALLidx_row, ALLidx_col] = ind2sub(size(AllValues1),Allidx);
    length(Allidx);

    % Calculate actual result
    tResAll=zeros([1,length(ALLidx_row)]);

    tnn15=zeros([1,length(ALLidx_row)]);
    tnn14=zeros([1,length(ALLidx_row)]);
    tnn13=zeros([1,length(ALLidx_row)]);
    tcosS15=zeros([1,length(ALLidx_row)]);
    tpaths215=zeros([1,length(ALLidx_row)]);
    tpaths214=zeros([1,length(ALLidx_row)]);
    tpaths213=zeros([1,length(ALLidx_row)]);
    tpaths315=zeros([1,length(ALLidx_row)]);
    tpaths314=zeros([1,length(ALLidx_row)]);
    tpaths313=zeros([1,length(ALLidx_row)]);
    tpaths415=zeros([1,length(ALLidx_row)]);
    tpaths414=zeros([1,length(ALLidx_row)]);
    tpaths413=zeros([1,length(ALLidx_row)]);
    tpaths515=zeros([1,length(ALLidx_row)]);
    tpaths514=zeros([1,length(ALLidx_row)]);
    tpaths513=zeros([1,length(ALLidx_row)]);

    tdegA15=zeros([1,length(ALLidx_row)]);
    tdegB15=zeros([1,length(ALLidx_row)]);
    tnumsA15=zeros([1,length(ALLidx_row)]);
    tnumsB15=zeros([1,length(ALLidx_row)]);
    tbtwcEA15=zeros([1,length(ALLidx_row)]);
    tbtwcEB15=zeros([1,length(ALLidx_row)]);

    tdist15=zeros([1,length(ALLidx_row)]);
    tdistAlt115=zeros([1,length(ALLidx_row)]);
    tdistAlt215=zeros([1,length(ALLidx_row)]);

    degreeY1=degreeY1/max(degreeY1(:));
    numsY1=numsY1/max(numsY1(:));

    KW1List=zeros([1,length(ALLidx_row)]);
    KW2List=zeros([1,length(ALLidx_row)]);

    for ii=1:length(ALLidx_row)
        KW1=ALLidx_row(ii);
        KW2=ALLidx_col(ii);
        if degreeY1(KW2)>degreeY1(KW1)
            tmp=KW1;
            KW1=KW2;
            KW2=tmp;
        end

        tResAll(ii)=nnFin(KW1,KW2)-nnY1(KW1,KW2);    

        KW1List(ii)=KW1;
        KW2List(ii)=KW2;

        %tnn15(ii)=nnY1(KW1,KW2);
        %tnn14(ii)=nnY2(KW1,KW2);
        %tnn13(ii)=nnY3(KW1,KW2);

        tdegA15(ii)=degreeY1(KW1);
        tdegB15(ii)=degreeY1(KW2);

        tnumsA15(ii)=numsY1(KW1);
        tnumsB15(ii)=numsY1(KW2);

    %    tbtwcEA15(ii)=btwcEY1(KW1);
    %    tbtwcEB15(ii)=btwcEY1(KW2);

        tcosS15(ii)=cosSY1(KW1,KW2);

        tpaths215(ii)=paths2Y1(KW1,KW2);
        tpaths214(ii)=paths2Y2(KW1,KW2);
        tpaths213(ii)=paths2Y3(KW1,KW2);
        tpaths315(ii)=paths3Y1(KW1,KW2);
        tpaths314(ii)=paths3Y2(KW1,KW2);
        tpaths313(ii)=paths3Y3(KW1,KW2);
        tpaths415(ii)=paths4Y1(KW1,KW2);
        tpaths414(ii)=paths4Y2(KW1,KW2);
        tpaths413(ii)=paths4Y3(KW1,KW2);
        tpaths515(ii)=paths5Y1(KW1,KW2);
        tpaths514(ii)=paths5Y2(KW1,KW2);
        tpaths513(ii)=paths5Y3(KW1,KW2);

        tdist15(ii)=distanceY1(KW1,KW2);
        tdistAlt115(ii)=distanceAlt1Y1(KW1,KW2);
        tdistAlt215(ii)=distanceAlt2Y1(KW1,KW2);    
    end
    %Pr=[tnn15;tnn14;tnn13;tdegA15;tdegB15;tnumsA15;tnumsB15;tcosS15;tpaths215;tpaths214;tpaths213;tpaths315;tpaths314;tpaths313;tpaths415;tpaths414;tpaths413;tdist15;tdistAlt115;tdistAlt215];

    tpaths215=tpaths215/max(tpaths215);
    tpaths214=tpaths214/max(tpaths214);
    tpaths213=tpaths213/max(tpaths213);
    tpaths315=tpaths315/max(tpaths315);
    tpaths314=tpaths314/max(tpaths314);
    tpaths313=tpaths313/max(tpaths313);
    tpaths415=tpaths415/max(tpaths415);
    tpaths414=tpaths414/max(tpaths414);
    tpaths413=tpaths413/max(tpaths413);

    tdistAlt115=tdistAlt115/max(tdistAlt115);
    tdistAlt215=tdistAlt215/max(tdistAlt215);    

    Pr=[tdegA15;tdegB15;...
        tnumsA15;tnumsB15;tcosS15;...
        tpaths215;tpaths214;tpaths213;tpaths315;tpaths314;tpaths313;tpaths415;tpaths414;tpaths413;...
        tdist15;tdistAlt115;tdistAlt215];

    Tr=tResAll;
    save(['EvalData' num2str(calcYearEval) '.mat'],'Pr','Tr','KW1List','KW2List')

end