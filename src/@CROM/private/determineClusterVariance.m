function v = determineClusterVariance(ai,c1_Labels, c1_Centers, type)

nCluster = size(c1_Centers,1);

%% Cluster variance
switch type
    case 'radius'
        %% Cluster radius
        r = determineClusterRadius(c1_Labels, c1_Centers);
        for iCluster = 1:nCluster
            v(iCluster) = r(iCluster)^2;%* q(iCluster); % ?????
        end
    case 'variance'    
        %% Cluster variance
        for iCluster = 1:nCluster
            % All snapshots one one cluster
            ai_set = ai(c1_Labels==iCluster,:);
            M_set  = size(ai_set,1);
            c1_Centers_rep = repmat(c1_Centers(iCluster,:),[M_set,1]);
            Diff_set  = ai_set' - c1_Centers_rep';
            D_set = sqrt(sum(Diff_set.^2,1)); % Two-norm of each column
            v(iCluster) = sum(D_set)/M_set;
        end
        
end