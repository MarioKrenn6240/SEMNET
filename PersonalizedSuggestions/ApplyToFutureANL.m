
c=clock;
timenow=[num2str(c(1)) num2str(c(2)) num2str(c(3))];

if ~exist('Pr')
    load('allKW201712Collaps_Deg0Removed.mat')

    load('TrainedNet2017.mat');
    load('EvalData2017.mat');
    disp('Finished reading data');

    [Yr,~,~,~,perf] = sim(net,Pr);
    
    degA15=Pr(1,:);
    degB15=Pr(2,:);
    numsA15=Pr(3,:);
    numsB15=Pr(4,:);
    cosS15=Pr(5,:);
    distS151=Pr(15,:);
    distS152=Pr(16,:);    
    distS153=Pr(17,:);

    a=min(Yr);
    b=max(Yr);
    yNorm=2*(Yr-a)/(b-a) - 1;
    
end

disp('Calculate 3d structure...')
SampleSize=length(Tr);
predIdx=(1:SampleSize);
predIdx=predIdx(randperm(SampleSize));

xcord=zeros([1,SampleSize]);
ycord=zeros([1,SampleSize]);
zcord=zeros([1,SampleSize]);
myKW1idx=zeros([1,SampleSize]);
myKW2idx=zeros([1,SampleSize]);

PointCount=0;

for ii=1:SampleSize
    N1=KW1List(predIdx(ii));
    N2=KW2List(predIdx(ii));  

    if (sum(MyGoodKWList==N1) + sum(MyGoodKWList==N2) > 0)
   %if (sum(MyGoodKWListAndrew==N1)>0 && sum(MyGoodKWListDenis==N2)>0)
        PointCount=PointCount+1;
        KW1=allKW{N1};
        KW2=allKW{N2};

        degA=degA15(predIdx(ii));
        degB=degB15(predIdx(ii));

        xcord(PointCount)=yNorm(predIdx(ii));  % x -> prediction from SemNet from -1, +1
        ycord(PointCount)=cosS15(predIdx(ii)); % similarity
        zcord(PointCount)=0.5*(degA+degB);     % average degree

        myKW1idx(PointCount)=N1;
        myKW2idx(PointCount)=N2;
        
    end

    if mod(ii,100000)==0
        disp([num2str(ii) '/' num2str(SampleSize)]);
    end    
    
end

xAll=xcord(1:PointCount);
yAll=ycord(1:PointCount);
zAll=zcord(1:PointCount);
KW1All=myKW1idx(1:PointCount);
KW2All=myKW2idx(1:PointCount);

xscale=xAll/std(xAll);
yscale=yAll/std(yAll);
zscale=zAll/std(zAll);

xmean=mean(xscale);
ymean=mean(yscale);
zmean=mean(zscale);

DistPoint=zeros([1,length(xAll)]);


xToPlotPre=xcord(1:PointCount);
yToPlotPre=ycord(1:PointCount);
zToPlotPre=zcord(1:PointCount);

for ii=1:length(xAll)
    distancefromMean=sqrt((xscale(ii)-xmean)^2+(yscale(ii)-ymean)^2+(zscale(ii)-zmean)^2);
    DistPoint(ii)=distancefromMean;
end

DistLimit=0;

xToPlot=xToPlotPre(DistPoint>DistLimit);
yToPlot=yToPlotPre(DistPoint>DistLimit);
zToPlot=zToPlotPre(DistPoint>DistLimit);

DistPoint=DistPoint(DistPoint>DistLimit);

%ATFplot3D

MaxPredictionsPersonalized