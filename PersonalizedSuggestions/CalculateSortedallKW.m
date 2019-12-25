% Makes a variable allKWsortedIdx which has the indices of the largest to
% the smallest KWs

sizeS=cellfun(@size,allKW,'uniform',false);
[trash allKWsortedIdx]=sortrows(cat(1,sizeS{:}),-[1 2]);
