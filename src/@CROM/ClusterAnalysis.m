function ClusterAnalysis(CROM)
% Call the clustering algorithm

ClusterRun  = cell(1,utils.Parameters.instance.parameters.nRepetitions);
kmeans_eval = zeros(utils.Parameters.instance.parameters.nRepetitions,1);
for iRun = 1:utils.Parameters.instance.parameters.nRepetitions
    % k-means
    [CROM.ClusteringResults.c0_Labels, CROM.ClusteringResults.c0_Centroids, ...
        CROM.ClusteringResults.sumD, CROM.ClusteringResults.D] = kmeans(CROM.Data.ts,...
        utils.Parameters.instance.parameters.nClusters, ...
        'MaxIter', utils.Parameters.instance.parameters.nIterations, ...
        'Distance', utils.Parameters.instance.parameters.distmetric, ...
        'Start', 'plus');
    
    % sorted transition matrix
    DTMC(CROM);
    
    ClusterRun{iRun}.P                  = CROM.P;
    ClusterRun{iRun}.c1_Labels          = CROM.c1_Labels;
    ClusterRun{iRun}.c1_Centroids       = CROM.c1_Centroids;
    ClusterRun{iRun}.q                  = CROM.q;
    ClusterRun{iRun}.sparsity           = CROM.sparsity;
    ClusterRun{iRun}.ClusteringResults  = CROM.ClusteringResults;
    
    if strcmp(utils.Parameters.instance.parameters.optimalClustering,'sparsity')
        kmeans_eval(iRun) = CROM.sparsity;
    else
        kmeans_eval(iRun)  = sum(CROM.ClusteringResults.sumD);
    end
end
[~,best_result] = max(kmeans_eval);


CROM.P                      = ClusterRun{best_result}.P;
CROM.c1_Labels              = ClusterRun{best_result}.c1_Labels;
CROM.c1_Centroids           = ClusterRun{best_result}.c1_Centroids;
CROM.q                      = ClusterRun{best_result}.q;
CROM.sparsity               = ClusterRun{best_result}.sparsity;
CROM.ClusteringResults      = ClusterRun{best_result}.ClusteringResults;
end