function [fitres, gof, output] = iterdecayfit(fitFunc, traceX, traceY, startVal, lowBound, maxrun, convergenceThreshold)
    % [fitres, gof] = iterdecayfit(fitFunc, traceX, traceY, startVal, maxrun, convergenceThreshold)
    % Iterative fitting routine
    
    % Initialize the R^2 (rsq) values to 0
    % rsq = r-squared parameter of the current run
    % rsq0 = r-squared parameter of the previous run
    rsq = 0;
    rsq0 = 0;

    % Fitting three sinusoidal decays
    %maxrun = 20;
    fitvals = zeros(maxrun,length(startVal));
    nrun = 0;
    
    % Run fitting routine in order to minimize the rsq
    while rsq < convergenceThreshold && nrun < maxrun
        
        % Store the r-squared parameter from last run
        rsq0 = rsq;
        %fitres0 = fitres;
        if rsq == 0 % First run
            [fitres, gof, output] = multioscfit(traceX, traceY, fitFunc, startVal, lowBound);
        elseif rsq <= rsq0 && nrun > 1 % When the fitting gets worse
            [fitres, gof, output] = multioscfit(traceX, traceY, fitFunc, fitvals(nrun-1,:), lowBound);
        elseif rsq > rsq0 % When the fitting gets better
            [fitres, gof, output] = multioscfit(traceX, traceY, fitFunc, fitvals(nrun,:), lowBound);
        end
        
        nrun = nrun + 1;
        rsq = gof.rsquare;
        fitvals(nrun,:) = coeffvalues(fitres);
        
        % Display message of the fitting result every round
        msg = sprintf('Current run = %d, R-squared = %d',nrun,rsq);
        disp(msg)

    end
    
end
