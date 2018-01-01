function fitfunc_flat = DecayModel(pars, x, ntrace)
    % Exponential decay model constructor
    
    nvecparam = ntrace*3;
    params = reshape(pars(1:nvecparam), ntrace, 3);
    a1 = params(:,1);
    a2 = params(:,2);
    z = params(:,3);
    c1 = pars(nvecparam+1);
    c2 = pars(nvecparam+2);
    d = pars(nvecparam+3);
    m = pars(nvecparam+4);
    
    term1 = (a1.*exp(-x/c1))*exp(m/c1+(d^2)/(2*c1^2)).*(1+erf((x-(m+d^2/c1))/(sqrt(2)*d)));
    term2 = (a2.*exp(-x/c2))*exp(m/c2+(d^2)/(2*c2^2)).*(1+erf((x-(m+d^2/c2))/(sqrt(2)*d)));
    fitfunc = term1' + term2' + z';
    fitfunc_flat = reshape(fitfunc, 1, numel(fitfunc));

end