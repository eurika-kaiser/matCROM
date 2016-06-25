function di_max = determineClusterDiameter(ai,c1_Labels)

% ------------------------------------- %
% --- determine cluster diameter  ----- %
% ----@created: 2013-12-06 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

nCluster = max(c1_Labels);

%% Compute diameter of attractor (takes into account only the centroids)
%D = importdata([pathSave,'D.dat']);
%[dmax,I] = max(max(D));

%% Compute diameter of each cluster
% diam(M) = sup{d(x,y): x,y, in M}
% d.h.: Maximalwert aller Abst"ande aller Zust"ande zueinander

for iCluster = 1:nCluster
    DataInCluster = ai(c1_Labels == iCluster,:); 
    NumbInCluster = size(DataInCluster,1);
    Di_tmp = zeros(NumbInCluster,NumbInCluster);
    for iState = 1:NumbInCluster
        for jState = 1:NumbInCluster
            Di_tmp(iState,jState) = sqrt((DataInCluster(iState,:)-DataInCluster(jState,:))* ...
                (DataInCluster(iState,:)-DataInCluster(jState,:))'); 
        end
    end
    di_max(iCluster,1) = max(max(Di_tmp));
    Di_tmp = 0;
    DataInCluster = 0;
    if utils.Parameters.instance.parameters.verbose
        disp(['Finished: Diameter of cluster ', num2str(iCluster)]);
    end
end