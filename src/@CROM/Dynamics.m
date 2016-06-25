function Dynamics(CROM)

% Powers of the transitionmatrix
P_powers = utils.Parameters.instance.parameters.powerLmat;
[CROM.Pl] = determineDynamicsOfCTM(CROM.P, P_powers);

% Evolution of probability vector for different initial conditions
L_powers = utils.Parameters.instance.parameters.powerL;
nCluster = utils.Parameters.instance.parameters.nClusters;
CROM.pl  = cell(nCluster,1);
for iCluster = 1:nCluster
    CROM.pl{iCluster,1} = determineDynamicsOfSPV(iCluster, CROM.P, L_powers);
end

% Asymptotic probability vector
CROM.pinf = CROM.P^(10^4)*[1/nCluster.*ones(nCluster,1)];

% Evolution of expected value for different IC
CROM.expectedValue  = cell(nCluster,1);
for iCluster = 1:nCluster
    CROM.expectedValue{iCluster,1} = determineExpectedValueEvolution(iCluster, CROM.c1_Centroids, CROM.P, L_powers);
end
end