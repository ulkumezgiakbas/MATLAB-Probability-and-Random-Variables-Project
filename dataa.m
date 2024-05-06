clear all;
Data1 = load('data.csv');
xdat = Data1(:,1);
ydat = Data1(:,2);
plot(xdat, ydat, '-');

logdist = @(f,t) (f(2) * ((t./ f(1)).^(f(2)-1))) / (f(1) * (1 + (t./ f(1)).^f(2)).^2);
startingVals = [150, 5];
logfit = fitnlm(xdat, ydat, logdist, startingVals);

xgrid = xdat;
line(xgrid, predict(logfit, xgrid), 'Color', 'r');

coeff = logfit.Coefficients.Estimate;
alpha = coeff(1);
beta = coeff(2);
hazard = (beta * ((xdat ./ alpha).^(beta -1))) ./ (alpha* (1 + (xdat ./ alpha).^beta));
figure;
plot(xdat, hazard, '-');
