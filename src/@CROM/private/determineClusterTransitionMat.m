function [P, c1_Labels, c1_Centers] = determineClusterTransitionMat(c0_Labels, c0_Centers, M, type, mTR)
% ---------------------------------- %
% --- Cluster transition matrix ---- %
% --- @created: 2013-09-06 EK   ---- %
% --- @depend : determineTransitionProbabilityOfOneCluster
% ----@revised: 2014-02-10 EK check  %
% ---------------------------------- %
% --- @info   :                  --- %
% --- 1) Determine c1 as max(q)  --- %
% --- 2) Determine c2 as max(P21) -- %
% ---------------------------------- %

unique_labels = unique(c0_Labels);
nCluster      = length(unique_labels);

%% Initialization
q0 = zeros(1,nCluster);                 % old cluster probability vector
P  = zeros(nCluster,nCluster);          % cluster transition matrix
c1_Labels  = zeros(M,1);                % new sorted labels
c1_Centers =  zeros(size(c0_Centers));  % new sorted cluster centers

%% Cluster probability vector of c0_Labels
for iCluster = 1:nCluster
    idx = c0_Labels==iCluster;
    c0_Labels_set = c0_Labels(idx);
    q0(iCluster) = sum(c0_Labels_set./iCluster)/size(c0_Labels,1);
end

%% CTM
switch type
    case 'basic'
        mTR = [];
        [P, IX_clusters] = determineCTM_basic(c0_Labels, M, q0);
    case 'neglectTransitions'
        [P, IX_clusters] = determineCTM_neglectTransitions(c0_Labels, M, q0, mTR);
end

%% Return variables
% Transpose transition probability matrix due to definition in JFM 
% Pjk : k -> j
P = P';

% Sort labels and centers
for kCluster = 1:nCluster
    idx             = find(c0_Labels == IX_clusters(kCluster));
    c1_Labels(idx)  = kCluster;
    c1_Centers(kCluster,:) = c0_Centers(IX_clusters(kCluster),:);
end

%% Check
if checkCTM(P, eps) ~= 1
    disp('ERROR: determineClusterTransitionMat: in P.')
    return;
end
    
%% Finished
if utils.Parameters.instance.parameters.verbose
    disp('Finished: Cluster transition matrix.')
end

end

function [P, IX_clusters] = determineCTM_basic(c0_Labels, M, q0)

nCluster = max(c0_Labels);

%% Largest cluster probability -> cluster 1
[~,idx]     = max(q0);
IX_clusters(1) = idx;      % Vec containes renaiming info

%% Transition probabilities 1->j, only M-1 transitions!
% All idx of new cluster 1
idx_InCluster{1} = find(c0_Labels(1:M-1) == IX_clusters(1));   

% All idx of next step clusters
idx_InCluster_OneStepAhead{1} = idx_InCluster{1} + ones(size(idx_InCluster{1}));

% Computes transition probability, IX sorted with descending trans. prob.
[Pkj(1,:),IX] = determineTransitionProbabilityOfOneCluster(c0_Labels,idx_InCluster_OneStepAhead{1});

%% Transition probabilities for remaining cluster 2, ..., nCluster
% Init
kCluster = 2;

% Loop
while kCluster <= nCluster
    idx_nextCluster = 1;                            % Index of next cluster is IX(1)
    while any(IX_clusters == IX(idx_nextCluster) )  % Find next cluster with highest transition probability k->k+1
        idx_nextCluster = idx_nextCluster + 1;      % If highest not available, take 2. highest, etc.
    end
    IX_clusters(kCluster) = IX(idx_nextCluster);    % Keep info on chosen next cluster
    
    % All idx of states in the cluster IX_clusters(kCluster) (with descending trans. probability 1->k)
    idx_InCluster{kCluster}  = find(c0_Labels(1:M-1)==IX_clusters(kCluster));
    
    % All idx of these states one time-step ahead 
    idx_InCluster_OneStepAhead{kCluster} = idx_InCluster{kCluster} + ones(size(idx_InCluster{kCluster}));
    
    % Transition probability: kCluster -> jCluster, IX sorted with descending trans. prob.
    [Pkj(kCluster,:),IX] = determineTransitionProbabilityOfOneCluster(c0_Labels,idx_InCluster_OneStepAhead{kCluster});
    
    % Next cluster = kCluster+1
    kCluster = kCluster + 1;
end

% Info: 
% Pkj are sorted correctly in rows
% IX_clusters contains the correct order

% Sorting
for kCluster = 1:nCluster
    P(kCluster,:) = Pkj(kCluster,IX_clusters);
end

end

function [P, IX_clusters] = determineCTM_neglectTransitions(c0_Labels, M, q0, mTR)

nCluster = numel(q0);
Nrm = size(mTR,2); 
Pkj = zeros(nCluster,nCluster);

%% Largest cluster probability -> cluster 1
[~,idx]     = max(q0);
IX_clusters(1) = idx;      % Vec containes renaiming info

for i = 1:Nrm
    %% Considered snapshots
    mstart = mTR(i,1);
    mend   = mTR(i,2);
    
    %% Transition probabilities 1->j, only M-1 transitions!
    % All idx of new cluster 1
    idx_InCluster{1} = find(c0_Labels(mstart:mend-1) == IX_clusters(1));   

    % All idx of next step clusters
    idx_InCluster_OneStepAhead{1} = idx_InCluster{1} + ones(size(idx_InCluster{1}));

    % Computes transition probability
    Pkj_tmp(1,:) = determineNumberOfTransitions(c0_Labels,idx_InCluster_OneStepAhead{1});
    
    %% Sum up transitions of all sub regimes
    Pkj(1,:) = Pkj(1,:) + Pkj_tmp(1,:);
end

%% IX sorted with descending trans. prob.
[~,IX] = sort(Pkj(1,:),'descend');

%% Transition probabilities for remaining cluster 2, ..., nCluster
% Init
kCluster = 2;

% Loop
while kCluster <= nCluster
    idx_nextCluster = 1;                            % Index of next cluster is IX(1)
    while any(IX_clusters == IX(idx_nextCluster) )  % Find next cluster with highest transition probability k->k+1
        idx_nextCluster = idx_nextCluster + 1;      % If highest not available, take 2. highest, etc.
    end
    IX_clusters(kCluster) = IX(idx_nextCluster);    % Keep info on chosen next cluster
    
    for i = 1:Nrm
        % Considered snapshots
        mstart = mTR(i,1);
        mend   = mTR(i,2);
        
        % All idx of states in the cluster IX_clusters(kCluster) (with descending trans. probability 1->k)
        idx_InCluster{kCluster}  = find(c0_Labels(mstart:mend-1)==IX_clusters(kCluster));
        
        % All idx of these states one time-step ahead
        idx_InCluster_OneStepAhead{kCluster} = idx_InCluster{kCluster} + ones(size(idx_InCluster{kCluster}));
        
        % Transition probability: kCluster -> jCluster, IX sorted with descending trans. prob.
        Pkj_tmp(kCluster,:) = determineNumberOfTransitions(c0_Labels,idx_InCluster_OneStepAhead{kCluster});
        
        % Sum up transitions of all sub regimes
        Pkj(kCluster,:) = Pkj(kCluster,:) + Pkj_tmp(kCluster,:);
    end
    %% IX sorted with descending trans. prob.
    [~,IX] = sort(Pkj(kCluster,:),'descend');
    
    % Next cluster = kCluster+1
    kCluster = kCluster + 1;
end

%% Final Sorting
% Info: 
% Pkj are sorted correctly in rows
% IX_clusters contains the correct order

for kCluster = 1:nCluster
    P(kCluster,:) = Pkj(kCluster,IX_clusters);
end

%% Check frequency
Psum = sum(sum(Pkj));
if utils.Parameters.instance.parameters.verbose
    disp(['CHECK: sum(sum(P)) = ',num2str(Psum)])
end

%% Normalisation
for iCluster = 1:nCluster
    P(iCluster,:) = P(iCluster,:)./sum(P(iCluster,:));
end

end

function Pkj = determineNumberOfTransitions(c0_Labels,idx_InCluster_OneStepAhead)
% ------------------------------------------------------------------- %
% --- Transition probability of one cluster to any other cluster ---- %
% --- @created: 2013-09-08 EK   ------------------------------------- %
% --- @revised: 2014-09-19 EK nCluster                           ---- %
% --- @depend :
% ------------------------------------------------------------------- %

unique_labels = unique(c0_Labels);
nCluster      = length(unique_labels); 

%% Variables
idx    = idx_InCluster_OneStepAhead;
labels = c0_Labels;
N      = size(labels(idx),1);           % total number of transitions
Pkj    = zeros(1,nCluster);             % transition probabilities from one cluster k

%% Calculate transition probabilities for one cluster k->j for all j

for jCenter = 1:nCluster
    Nj(1,jCenter) = size( labels (labels(idx) == jCenter) ,1);   % number of transitions to one cluster
    if N == 0
        Pkj(1,jCenter) = 0;                                      % prob. from given i to any j
        disp('WARNING (Comput. of P): Total number of states in box is zero! -> pi(k,jCenter)=0')
    else
        Pkj(1,jCenter) = Nj(1,jCenter);
    end
end

end
