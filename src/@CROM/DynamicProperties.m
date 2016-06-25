function DynamicProperties(CROM)
L_powers = utils.Parameters.instance.parameters.powerL;

% Finite-Time Lyapunov exponent
[CROM.ftle] = FTLE(CROM.P,L_powers);

% Kullback-Leibler entropy
[CROM.kle, ~] = CROM.KLE(CROM.P, [CROM.P^(10^4)], L_powers);

% Variance
nCluster = utils.Parameters.instance.parameters.nClusters;
CROM.Variance = determineVarianceOfCTM(CROM.Data.ts,nCluster, CROM.q, CROM.c1_Labels, CROM.c1_Centroids, CROM.P, CROM.pinf);
end