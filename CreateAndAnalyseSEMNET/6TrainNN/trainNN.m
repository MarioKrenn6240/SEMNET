close all
run('..\GetValues.m')
rng('shuffle')


for tNNii=1:length(yearlimits)-PredictionInterval-2
    disp(['Train NN with Data from ' num2str(yearlimits(tNNii)-PredictionInterval) ' to predict ' num2str(yearlimits(tNNii))]);
    load(['..\5PrepareNNData\TrainData' num2str(yearlimits(tNNii)-PredictionInterval) '.mat']);    


    
    figure(1)
    plot(T)
    title('tResAll')
    set(1,'Position',[47   400   560   420])

    rng();
    net = feedforwardnet([50,50]);
    %net = fitnet([]);
    % train net
    net.divideParam.trainRatio = 0.8; % training set [%]
    net.divideParam.valRatio = 0.1; % validation set [%]
    net.divideParam.testRatio = 0.1; % test set [%]
    net.trainparam.epochs=50;


    [net,tr,Y,~] = train(net,P,T);

    evaluateIt

    c=clock;
    timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];
    save(['TrainedNet' num2str(yearlimits(tNNii)) '.mat'], 'net');
end
