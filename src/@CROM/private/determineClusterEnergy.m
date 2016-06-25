function energy = determineClusterEnergy(ai,c1_Labels)

% ------------------------------------- %
% --- determine cluster energy    ----- %
% ----@created: 2014-10-04 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %
if utils.Parameters.instance.parameters.verbose
    disp('Computing mean energy of clusters .... ')
    disp('IMPORTANT: Assumes POD coeff. and computes energy as e(tm) = 1/2 * sum_i ai^2(tm).')
end
nCluster = numel(unique(c1_Labels));

%% Compute energy of each cluster

energy = zeros(nCluster,1);

for iCluster = 1:nCluster
    DataInCluster = ai(c1_Labels == iCluster,:); 
    NumbInCluster = size(DataInCluster,1);
    for iData = 1:NumbInCluster
        energy(iCluster) = energy(iCluster) + 1/2*sum(DataInCluster(iData,:).^2); 
    end
    energy(iCluster) = energy(iCluster)/NumbInCluster;
    if utils.Parameters.instance.parameters.verbose
        disp(['Finished: Mean energy of cluster ', num2str(iCluster)]);
    end
end