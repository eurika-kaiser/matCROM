function DataSet = TransitionMatrixIdentification(Labels, timelag, Actuation, params, CTM_case,nCluster)
%HERE: column stochastic!
% If not action-dependent
if nargin == 2 || (nargin == 6 && isempty(params)==1)
    params.states = 1;
    Actuation        = ones(size(Labels));
end
if nargin < 5 || (nargin == 6 && isempty(CTM_case)==1)
    CTM_case = 'constant';
end

% Parameters
nStates  = length(params.states);
u_states = zeros(size(Actuation,1),1);
M        = size(Labels,1);

% Construct timeseries of state indices of control input
for iState = 1:nStates
    if size(Actuation,2)>1
        for i=1:size(Actuation,1)
           if (Actuation(i,1) ==  params.states(iState,1)) && (Actuation(i,2) ==  params.states(iState,2))
               u_states(i) = iState;
           end
        end
    else
        idx           = find(Actuation == params.states(iState,:));
        u_states(idx) = iState;
    end
end


% Different cases
switch CTM_case
    case 'constant'
        if nargin < 6
            nCluster = max(Labels);
        end
        
        % Determine Frequencies
        DataSet.F = zeros(nCluster,nCluster,nStates);
        for m = 1 : M - timelag
            k = Labels(m);
            i = u_states(m);
            j = Labels(m+timelag);
            DataSet.F(j,k,i) =  DataSet.F(j,k,i) + 1;
        end
       
        
    case 'custom'
        nCluster = max(max(Labels));
        
        % Determine Frequencies
        DataSet.F = zeros(nCluster,nCluster,nStates);
        for m = 1 : M - timelag
            k = Labels(m,1);
            i = u_states(m);
            j = Labels(m,2);
            DataSet.F(j,k,i) =  DataSet.F(j,k,i) + 1;
        end
        
    case 'lag'
        nCluster = max(max(Labels));
        
        % Determine Frequencies
        DataSet.F = zeros(nCluster,nCluster,nStates);
        for m = 2 : M - timelag
            k = Labels(m+timelag-1);
            i = u_states(m);
            j = Labels(m+timelag);
            DataSet.F(j,k,i) =  DataSet.F(j,k,i) + 1;
        end
    case 'last_state'
        nCluster = max(max(Labels));
        
        % Determine Frequencies
        DataSet.F = zeros(nCluster,nCluster,nStates);
        for m = 2 : M
            k = Labels(m-1);
            i = u_states(m);
            j = Labels(m);
            DataSet.F(j,k,i) =  DataSet.F(j,k,i) + 1;
        end
end

% Determine transition probabilities
DataSet.P = zeros(size(DataSet.F));
for iState = 1:nStates
    for k = 1:nCluster
        if any(DataSet.F(:,k,iState) ~= 0)
            DataSet.P(:,k,iState) = DataSet.F(:,k,iState)./sum(DataSet.F(:,k,iState));
        end
    end
end



end