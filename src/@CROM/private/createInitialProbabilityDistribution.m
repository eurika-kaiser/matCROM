function p0 = createInitialProbabilityDistribution(pIC,nCluster)

%% Create IC p0
p0  = zeros(nCluster,1);
if pIC == 0
    p0 = 1/nCluster.*ones(nCluster,1);    % equipartition
else
    p0(pIC) = 1;            % start in one cluster
end
