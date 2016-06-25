function Variance = determineVarianceOfCTM(ai,K, q, c1_Labels, c1_Centers, P, pinf)

% ------------------------------------- %
% --- determine variance of CTM ------- %
% ----@created: 2013-10-30 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

%% Init
p0 = zeros(size(q));
%V  = zeros(K,K);   
V  = zeros(K,1);
Variance = [];

%% Intrinsic cluster variances -> cluster radius
Vintrinsic = determineClusterVariance(ai,c1_Labels, c1_Centers, 'variance');    

%% Calculation starting in each cluster

for jCluster = 1 : K   

    %% Start in one cluster
    p0(jCluster) = 1;
    
    %% Probabilities to be in a cluster after one time step
    p1 = P*p0;

    %% Expectation value of centroid
    mj = determineExpectation(c1_Centers, P, jCluster);
    
    %% Calculation for all transitions from starting cluster
    for iCluster = 1 : K
        %mj = c1_Centers(iCluster,:);
        %V(jCluster) = V(jCluster) + q(iCluster)*( sum( (c1_Centers(iCluster,:) - mj).^2 ) +
        %Vintrinsic(iCluster) ); % original
        V(jCluster) = V(jCluster) + p1(iCluster)*( sum( (c1_Centers(iCluster,:) - mj).^2 ) + Vintrinsic(iCluster) );
    end
    
    %V(jCluster) = q(jCluster)*V(jCluster); % original
    V(jCluster) = pinf(jCluster)*V(jCluster);
    
    %% Init p0
    p0 = zeros(size(q));   
end
%Variance = sum(sum(V));
Variance = sum(V);
end


function m = determineExpectation(c1_Centers, P, startCluster)

% ------------------------------------- %
% --- determine cluster radius -------- %
% ----@created: 2013-10-29 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

nCluster = size(P,1);

%% Expectation
m = zeros(size(c1_Centers(1,:)));
for iCluster = 1:nCluster
    m = m + P(iCluster,startCluster)*c1_Centers(iCluster,:);
end
end