function [pL] = determineDynamicsOfSPV(pIC, P, pDynamics)
% ------------------------------------- %
% --- determine dynamics of CTM     --- %
% ----@created: 2013-09-27 EK --------- %
% ----@revised: 2014-02-11 EK --------- %
% ------------------------------------- %

%% Create IC p0
nCluster = size(P,1);
p0 = createInitialProbabilityDistribution(pIC,nCluster);

%% Dynamics of CTM
pL(1,:) = p0;
for l = 1:pDynamics
    pL(l+1,:) = P^l*p0;
end

