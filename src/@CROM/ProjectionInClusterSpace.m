function ProjectionInClusterSpace(CROM)
nCluster = utils.Parameters.instance.parameters.nClusters;
CROM.expVal_r = cell(nCluster,1);
for iCluster = 1:nCluster
    [CROM.expVal_r{iCluster},~] = CROM.compLowOrderRepresentation(CROM.expectedValue{iCluster},CROM.c1_Centroids, ...
        utils.Parameters.instance.parameters.rDim,utils.Parameters.instance.parameters.rVec);
end
end