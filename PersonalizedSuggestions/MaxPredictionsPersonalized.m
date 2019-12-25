% xAllt: values of SemNet for the concept pair (-1...+1)
% yAllt: cosSimilarities of concept pairs
% zAllt: average degree of concept pairs

% will show concept pair with largest distance from average (i.e. outlier)
% in terms of prediction, cosS, degree.

xAllt=xAll;
yAllt=yAll;
zAllt=zAll;

xmean=mean(xAllt);
xstd=std(xAllt);
ymean=mean(yAllt);
ystd=std(yAllt);
zmean=mean(zAllt);
zstd=std(zAllt);

xdiff=abs(xAllt-xmean)/xstd;
ydiff=abs(yAllt-ymean)/ystd;
zdiff=abs(zAllt-zmean)/zstd;


outlier=sqrt(xdiff.^2+ydiff.^2+zdiff.^2);
%outlier=sqrt(ydiff.^2+zdiff.^2); %different possible outlier-detection,
%only cosS and deg

objective=outlier;

nn=1;
%for ii=1:10
while nn<10
    [val,idx]=max(objective);
    %disp([num2str(ii) ' (' num2str(idx) '): ' allKW{KW1Allt(idx)} ', ' allKW{KW2Allt(idx)} ' (cosS: ' num2str(yAllt(idx)) ', deg: ' num2str(num2str(zAllt(idx))) ', pred: ' num2str(num2str(xAllt(idx))) ')'])

    if xAllt(idx)>-100
        disp([allKW{KW1Allt(idx)} ', ' allKW{KW2Allt(idx)} ': cosS: ' num2str(yAllt(idx)) ', deg: ' num2str(num2str(zAllt(idx))) ', pred: ' num2str(num2str(xAllt(idx)))])
        nn=nn+1;
    end
    
    objective(idx)=0;
end

