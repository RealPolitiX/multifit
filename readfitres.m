function [fitval, moerr] = readfitres(fitres)
    
    fitval = coeffvalues(fitres);
    ci = confint(fitres);
    moerr = fitval - ci(1,:);
    
end