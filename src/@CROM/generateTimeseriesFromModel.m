function chain = generateTimeseriesFromModel(P, Np, IC)
% Generate time series from the Markov model
% Input: Np - length of time series
%        P  - Transition matrix
%        IC - initial condition
% Output: chain - Time series obtained from Markov chain

chain       = zeros(1,Np);
chain(1)    = IC;

for i=2:Np
    % Get cumulative transition distribution
    % Box length proportional to probability
    this_step_distribution  = P(:,chain(i-1));
    cumulative_distribution = cumsum(this_step_distribution);
    
    % A random value between 0 and 1
    r = rand();
    
    % Find idx into which box r falls
    chain(i) = find(cumulative_distribution>r,1);
end

figure,plot(1:Np,chain,'+-k','MarkerSize',8)


end