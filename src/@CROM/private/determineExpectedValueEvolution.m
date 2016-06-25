function m = determineExpectedValueEvolution(pIC, c1_Centers, P, pDynamics)

% ------------------------------------- %
% --- determine expected value  ------- %
% ----@created: 2014-02-11 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

%% Create IC p0
nCluster = size(c1_Centers,1);
p0 = createInitialProbabilityDistribution(pIC,nCluster);

%% Erwartungswert
m = zeros(pDynamics, size(c1_Centers,2));

for l = 0:pDynamics
    pl       = P^l*p0;
    m(l+1,:) = determineExpectedValue(c1_Centers, pl);
end
