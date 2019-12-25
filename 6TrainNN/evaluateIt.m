[Y,~,~,~,~] = sim(net,P);
allErr=sqrt(sum((T-Y).^2));
disp(['Error: ' num2str(allErr)])

