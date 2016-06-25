function D = determineClusterDistanceMatrix(c1_Centers)
% ------------------------------------- %
% --- determine distance matrix ------- %
% ----@created: 2013-09-24 EK --------- %
% ----@revised: 2014-02-10 EK --------- %
% ----@revised: 2014-09-19 EK nCluster %
% ----@depends: dist_Euclidean    ----- %
% ------------------------------------- %

nCluster = size(c1_Centers,1);

%% Compute distances of cluster centers
D = zeros(nCluster,nCluster);
for iCluster = 1:1:nCluster
    for jCluster = 1:nCluster
        D(iCluster,jCluster) = dist_Euclidean(c1_Centers(iCluster,:), c1_Centers(jCluster,:)); 
    end
end

