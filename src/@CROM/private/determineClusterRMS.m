function RMS = determineClusterRMS(ai,c1_Labels, c1_Centers)

% ------------------------------------- %
% --- determine cluster rms       ----- %
% ----@created: 2013-12-06 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

nCluster = numel(unique(c1_Labels));

%% Compute diameter of each cluster
% diam(M) = sup{d(x,y): x,y, in M}
% d.h.: Maximalwert aller Abst"ande aller Zust"ande zueinander

RMS = zeros(nCluster,1);

for iCluster = 1:nCluster
    DataInCluster = ai(c1_Labels == iCluster,:); 
    NumbInCluster = size(DataInCluster,1);
    for iData = 1:NumbInCluster
        RMS(iCluster) = RMS(iCluster) + (c1_Centers(iCluster,:) - DataInCluster(iData,:))* ...
            (c1_Centers(iCluster,:) - DataInCluster(iData,:))'; 
    end
    RMS(iCluster) = sqrt(RMS(iCluster)/NumbInCluster);
    if utils.Parameters.instance.parameters.verbose
        disp(['Finished: RMS of cluster ', num2str(iCluster)]);
    end
end