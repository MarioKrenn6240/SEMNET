%addpath '..\matlab_bgl';
% in: nnAncient, numsAncient



% degree
disp('Calculate: Degree')
tic
degreeAncient=sum(nnAncient>0);
toc

% Betweenness centrality
% disp('Calculate: Betweenness Centrality')
% tic
% ss=sparse(nnAncient);
% [btwcEAncient,~]=betweenness_centrality(ss);
% btwcEAncient=btwcEAncient./max(btwcEAncient);
% toc


% distance
disp('Calculate: distance')
tic
nnTmp=nnAncient;
nnTmp(nnTmp>0)=1;
nns=sparse(nnTmp);
distanceAncient=graphallshortestpaths(nns);
distanceAncientTmp=distanceAncient;
distanceAncientTmp(isinf(distanceAncientTmp))=0;
distanceAncient(isinf(distanceAncient))=2*max(distanceAncientTmp(:));
toc

disp('Calculate: alternative distance1')
tic
deg=sum(nnAncient>0);
degA=repmat(deg,length(nnAncient),1);
degB=repmat(deg,length(nnAncient),1)';
mm1=sqrt(degA .* degB)./nnAncient;
mm1(isinf(mm1))=0;
mm1=mm1.*(1-eye(length(mm1)));
nnTmp=mm1;
nns=sparse(nnTmp);
distanceAlt1Ancient=graphallshortestpaths(nns);
distanceAncientTmp=distanceAlt1Ancient;
distanceAncientTmp(isinf(distanceAncientTmp))=0;
distanceAlt1Ancient(isinf(distanceAlt1Ancient))=2*max(distanceAncientTmp(:));

toc

disp('Calculate: alternative distance2')
tic
hash=sum(nnAncient);
hashA=repmat(hash,length(nnAncient),1);
mm2=(hashA .* hashA')./nnAncient;
mm2(isinf(mm2))=0;
mm2=mm2.*(1-eye(length(mm2)));
nnTmp=mm2;
nns=sparse(nnTmp);
distanceAlt2Ancient=graphallshortestpaths(nns);
distanceAncientTmp=distanceAlt2Ancient;
distanceAncientTmp(isinf(distanceAncientTmp))=0;
distanceAlt2Ancient(isinf(distanceAlt2Ancient))=2*max(distanceAncientTmp(:));
toc

% Paths
disp('Calculate: Paths 2 (cosS), 3, 4, 5')
tic
mm=double(nnAncient);
mat=mm*mm;
degN=sum(mm);
normN=((degN' * degN).^(1/2));
paths2Ancient=mat./normN;
paths2Ancient(isnan(paths2Ancient))=0;

mat=mat*mm;
degN=sum(mm);
normN=((degN' * degN).^(1/2));
paths3Ancient=mat./normN;
paths3Ancient(isnan(paths3Ancient))=0;

mat=mat*mm;
degN=sum(mm);
normN=((degN' * degN).^(1/2));
paths4Ancient=mat./normN;
paths4Ancient(isnan(paths4Ancient))=0;

mat=mat*mm;
degN=sum(mm);
normN=((degN' * degN).^(1/2));
paths5Ancient=mat./normN;
paths5Ancient(isnan(paths5Ancient))=0;
toc

% Paths
disp('Calculate: Cosine Similarity')
tic
mm=double(nnAncient>0);
mat=mm*mm;
degN=sum(mm);
normN=((degN' * degN).^(1/2));
cosSAncient=mat./normN;
cosSAncient(isnan(cosSAncient))=0;


% 
% disp('Calculate: Adamic-Adar score')
% tic
% disp('2009');
% mm=double(nn200912>0);
% deg=sum(mm>0);
% [R,C] = find(triu(mm*mm.',1));
% out=zeros(size(mm));
% for ii=1:numel(R)
%     out(R(ii),C(ii)) = sum(1./log(mm(R(ii),:).*mm(C(ii),:).*deg));
% end
% adamic200912=out;
% adamic200912=adamic200912+adamic200912';
% norm=(degree200912' * degree200912).^(1/2);
% adamic200912=adamic200912./norm;
% toc
% 
% tic
% disp('2008');
% mm=double(nn200812>0);
% deg=sum(mm>0);
% [R,C] = find(triu(mm*mm.',1));
% out=zeros(size(mm));
% for ii=1:numel(R)
%     out(R(ii),C(ii)) = sum(1./log(mm(R(ii),:).*mm(C(ii),:).*deg));
% end
% adamic200812=out;
% adamic200812=adamic200812+adamic200812';
% norm=(degree200812' * degree200812).^(1/2);
% adamic200812=adamic200812./norm;
% toc
% 
% tic
% disp('2007');
% mm=double(nn200712>0);
% deg=sum(mm>0);
% [R,C] = find(triu(mm*mm.',1));
% out=zeros(size(mm));
% for ii=1:numel(R)
%     out(R(ii),C(ii)) = sum(1./log(mm(R(ii),:).*mm(C(ii),:).*deg));
% end
% adamic200712=out;
% adamic200712=adamic200712+adamic200712';
% norm=(degree200712' * degree200712).^(1/2);
% adamic200712=adamic200712./norm;
% toc
