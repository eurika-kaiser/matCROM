function [Pkj,IX] = determineTransitionProbabilityOfOneCluster(c0_Labels,idx_InCluster_OneStepAhead)
% ------------------------------------------------------------------- %
% --- Transition probability of one cluster to any other cluster ---- %
% --- @created: 2013-09-08 EK   ------------------------------------- %
% --- @depend :
% ------------------------------------------------------------------- %


%% Global variables
nCluster = max(c0_Labels);

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
        Pkj(1,jCenter) = Nj(1,jCenter)./N;
    end
end

%% Sort probabilities
[~,IX] = sort(Pkj,'descend');


