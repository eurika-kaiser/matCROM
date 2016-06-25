function q = determineClusterProbVec(c1_Labels)

% ------------------------------------- %
% --- determine cluster probabilities - %
% ----@created: 2013-09-24 EK --------- %
% ----@revised: 2014-02-10 EK check --- %
% ----@depends:                   ----- %
% ------------------------------------- %

%% Global variables
M = length(c1_Labels);
nCluster = length(unique(c1_Labels));

%% Calculate probabilities to be in a cluster
q = zeros(nCluster,1);
for iCluster = 1:nCluster
    n_labels    = c1_Labels((c1_Labels == iCluster));
    q(iCluster) = length(n_labels)/M;
end

%% check
if checkClusterProbVec(q,eps) ~= 1
    return;
end

