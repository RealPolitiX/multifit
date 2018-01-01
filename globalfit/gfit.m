% Preparations for fitting
% Prepare fitting data
datamat = relc';
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
lb_flat(end+1:end+4) = [-Inf, -Inf, 150, -Inf];

ub = ones(np, nparamdim)*Inf;
ub(:, nparamdim-1) = 0.006;
ub_flat = reshape(ub, 1, numel(lb));
ub_flat(end+1:end+4) = [Inf, Inf, 250, Inf];

% Additional fitting parameters and conditions
ops = optimset('Display','iter');

%%
% % Model test
% out = DecayModel(inits_flat, dtaxis, np);
% size(out)

%%
% Perform fit
[fitvals,resnorm,res,exitflag,output,lambda,jac] = ...
    lsqcurvefit(@(params,dtaxis)DecayModel(params,dtaxis,np),...
    inits_flat, dtaxis, datamat_flat, lb_flat, ub_flat, ops);

%%
% Extract fitting results
idx = [1:floor(numel(fitvals)/np)]*np;
a1_fit = fitvals(1:idx(1));
a2_fit = fitvals(idx(1)+1:idx(2));
z_fit = fitvals(idx(2)+1:idx(3));

c1_fit = fitvals(idx(3)+1);
c2_fit = fitvals(idx(3)+2);
d_fit = fitvals(idx(3)+3);
m_fit = fitvals(idx(3)+4);

% Construct fitting parameter dictionary
varlib = dictConstructor({}, {'a1',a1_fit},{'a2',a2_fit},{'z',z_fit},...
    {'c1',c1_fit},{'c2',c2_fit},{'d',d_fit},{'m',m_fit});

fitdyn = DecayModel(fitvals, dtaxis);
fitdyn = reshape(fitdyn, nt, np);

%%
% Display fitting results
for icurv = 1:50
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

%%
% Restructure the ci matrix and append to varlib
a1_ci = ci(1:idx(1),:)';
a2_ci = ci(idx(1)+1:idx(2),:)';
z_ci = ci(idx(2)+1:idx(3),:)';

c1_ci = ci(idx(3)+1,:);
c2_ci = ci(idx(3)+2,:);
d_ci = ci(idx(3)+3,:);
m_ci = ci(idx(3)+4,:);

varlib = dictConstructor(varlib, {'a1_ci',a1_ci},{'a2_ci',a2_ci},{'z_ci',z_ci},...
    {'c1_ci',c1_ci},{'c2_ci',c2_ci},{'d_ci',d_ci},{'m_ci',m_ci});

%%
% Save global fitting results
save('2016-12-14_Scan_34_gfit.mat','redmat','dtaxis','inits_flat','fitvals',...
    'lb_flat','ub_flat','fitdyn','varlib','output','res','jac')
