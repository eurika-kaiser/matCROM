function DTMC(CROM)
% Computes transition probability matrix and sorts clusters
[CROM.P, CROM.c1_Labels, CROM.c1_Centroids] = determineClusterTransitionMat(CROM.ClusteringResults.c0_Labels, ...
    CROM.ClusteringResults.c0_Centroids, ...
    CROM.M,'basic', []);

% Computes how sparse the transition matrix is
CROM.sparsity = determineSparsityOfCTM(CROM.P);

% Cluster probability matrix qk = #snapshots in cluster k / #total snapshots
CROM.q = determineClusterProbVec(CROM.c1_Labels);
end