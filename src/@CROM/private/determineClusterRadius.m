function r = determineClusterRadius(ai, c1_Labels, c1_Centers)

% ------------------------------------- %
% --- determine cluster radius -------- %
% ----@created: 2013-10-29 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

nCluster = size(c1_Centers,1);
r        = zeros(nCluster,1);

%% Cluster radius
for iCluster = 1:nCluster
   % All snapshots one one cluster
   ai_set = ai(c1_Labels==iCluster,:);
   M_set  = size(ai_set,1);
   c1_Centers_rep = repmat(c1_Centers(iCluster,:),[M_set,1]);
   Diff_set  = ai_set' - c1_Centers_rep'; 
   D_set = sqrt(sum(Diff_set.^2,1)); % Two-norm of each column 
   r(iCluster) = max(D_set);
end
