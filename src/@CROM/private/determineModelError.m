function [d2,t,tau] = determineModelError(P,c1_Centers,c1_Labels, ai, dt)

% ------------------------------------- %
% --- determine model error      ------ %
% --- squared distance           ------ %
% ----@created: 2014-01-27 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

M = length(c1_Labels);
nCluster = size(P,1);

%% Init
t = (0:M-1).*dt;
tau = 1;
%% Initial condition
ai0 = ai(1,:);
p0  = zeros(nCluster,1); p0(c1_Labels(1)) = 1;

%% Calculation
d2 = determineSquaredDistanceForCTM(M, p0, P, ai, c1_Centers, c1_Centers);

%% Save 
%saveData
% ============================================================================================    



function d2 = determineSquaredDistanceForCTM(M_i,p0, P, ai_i, c1_Centers, c1_Centroids)
nCluster = size(P,1);
tm = 1;
pt = p0;
ci_ExpectedValue = determineExpectedValue(c1_Centers, pt);
ai_ProjectedOntoCentroids = determineProjectionOntoCentroids(ai_i(tm,:),c1_Centroids,nCluster);
d2(tm) = determineTimestepDependentSquaredDistance(ai_ProjectedOntoCentroids,ci_ExpectedValue);
%% Loop for distances
for tm = 2:1:M_i
    
    %% 2.0 - Compute time dependent probability vector
    pt = P^(tm-1)*p0;      % probability vector at time t*dt
    
    %% 2.1 - Expected value from Markov model
    ci_ExpectedValue = determineExpectedValue(c1_Centers, pt);
    
    %% 2.2 - Projection of ai onto centroids
    ai_ProjectedOntoCentroids = determineProjectionOntoCentroids(ai_i(tm,:),c1_Centroids,nCluster);
    
    %% 2.3 - squared distance
    d2(tm) = determineTimestepDependentSquaredDistance(ai_ProjectedOntoCentroids,ci_ExpectedValue);
    
end

% ----------------------------------------------------------------------------------- %

function ci_ExpectedValue = determineExpectedValue(c1_Centers, pt)
ci_ExpectedValue = c1_Centers'*pt;
ci_ExpectedValue = ci_ExpectedValue';


% ----------------------------------------------------------------------------------- %
function ai_ProjectedOntoCentroids = determineProjectionOntoCentroids(ai_tm,c1_Centers, nCluster)
% 1 - Quick & dirty: ai_projected = closest cluster
% 2 - Better: Projection with barycentric coordinates, projection onto surface
dist = zeros(nCluster,1);
for iCluster = 1:nCluster
    dist(iCluster) = sqrt((ai_tm - c1_Centers(iCluster,:))*(ai_tm - c1_Centers(iCluster,:))');
end
[~,idx_ClosestCluster] = min(dist);
ai_ProjectedOntoCentroids = c1_Centers(idx_ClosestCluster,:);

% ----------------------------------------------------------------------------------- %

function d2 = determineTimestepDependentSquaredDistance(ai_ProjectedOntoCentroids,ci_ExpectedValue)
d2 = sum((ai_ProjectedOntoCentroids - ci_ExpectedValue)*(ai_ProjectedOntoCentroids - ci_ExpectedValue)');


