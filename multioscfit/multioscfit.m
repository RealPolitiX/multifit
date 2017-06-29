function [fitresult, gof, output] = multioscfit(TPoints, Trace, FitFunction, StartValues, LowerBound)

	[xData, yData] = prepareCurveData(TPoints, Trace);

	% Set up fittype and options.
	ft = fittype(FitFunction,'independent','x','dependent','y');
	opts = fitoptions(ft);
	%opts.Method = 'NonlinearLeastSquares';
	opts.Display = 'Off';
	opts.Lower = LowerBound;
	opts.Algorithm = 'Trust-Region';
	opts.MaxIter = 100;
	opts.Robust = 'Bisquare';
	opts.StartPoint = StartValues;
	opts.Upper = Inf*numel(StartValues);

	% Fit model to data.
	[fitresult, gof, output] = fit(xData, yData, ft, opts);

end
