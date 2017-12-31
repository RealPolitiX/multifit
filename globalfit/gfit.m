% Preparations for fitting
% Prepare fitting data
datamat = redmat;
dtaxis = taxis - taxis(5);
[nt, np] = size(datamat);
datamat_flat = reshape(datamat, 1, numel(datamat));

% Specify initial guesses
x0 = [0.1, -0.1, 0.001];
nparamdim = numel(x0);
inits = repmat(x0, np, 1);
inits_flat = reshape(inits, 1, numel(inits));
inits_flat(end+1:end+4) = [1e6 300 200 200];  % Append scalar variables at the end

% Specify lower and upper bounds
lb = ones(np, nparamdim)*(-Inf);
lb(:, nparamdim-1) = -0.006;
lb_flat = reshape(lb, 1, numel(lb));
lb_flat(end+1:end+4) = [-Inf, -Inf, 0, -Inf];

ub = ones(np, nparamdim)*Inf;
ub(:, nparamdim-1) = 0.006;
ub_flat = reshape(ub, 1, numel(lb));
ub_flat(end+1:end+4) = [Inf, Inf, Inf, Inf];

% Additional fitting parameters and conditions
ops = optimset('Display','iter');

%%
% % Model test
% out = DecayModel(inits_flat, dtaxis);
% size(out)

%%
% Perform fit
[fitvals,resnorm,res,exitflag,output,lambda,jac] = ...
    lsqcurvefit(@(params,dtaxis)DecayModel(params,dtaxis),...
    inits_flat, dtaxis, datamat_flat, lb_flat, ub_flat, ops);

% Extract fitting results
fitmat = reshape(fitvals(1:39), np, floor(numel(fitvals)/np));
a1_fit = fitmat(:,1);
a2_fit = fitmat(:,2);
c1_fit = fitvals(40);
c2_fit = fitvals(41);
d_fit = fitvals(42);
m_fit = fitvals(43);
z_fit = fitmat(:,3);
fitdyn = DecayModel(fitvals, dtaxis);
fitdyn = reshape(fitdyn, nt, np);

%%
% Display fitting results
for icurv = 1:np
    figure;
    hold on
    plot(dtaxis, datamat(:,icurv))
    plot(dtaxis, fitdyn(:,icurv), 'LineWidth',2)
    legend('data','fit')
    xlabel('Probe delay (fs)')
    ylabel('Whitened relative change')
    title('Fitting with fixed offset')
    box on
    grid on
    hold off
end

%%
% Calculate confidence interval
ci = nlparci(fitvals,res,'Jacobian',jac);