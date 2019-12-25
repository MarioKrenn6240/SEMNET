
run('..\GetValues.m') % yearlimits

for ii=1:length(yearlimits)
    tic
    DateLimit=yearlimits(ii)*100+12;
    disp(['Create ancient network at time ' num2str(DateLimit)]);
    networkTAncient=cellfun(@(x) x(x<=DateLimit), networkT, 'UniformOutput', false);
    toc

    disp('Calculate nn');
    nnAncient=cellfun('length',networkTAncient);

    numsT=cell([1,length(networkTAncient)]);
    for jj=1:length(networkTAncient)
        numsT{jj}=unique(horzcat(networkTAncient{jj,:}));
    end
    numsAncient=cellfun('length',numsT);
    save(['nn' num2str(yearlimits(ii)) '12Collaps.mat'],'nnAncient','numsAncient');
end