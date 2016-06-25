function m = determineExpectedValue(c1_Centers, p)

% ------------------------------------- %
% --- determine expected value  ------- %
% ----@created: 2013-10-29 EK --------- %
% ----@revised: 2014-02-11 EK --------- %
% ----@depends:                   ----- %
% ------------------------------------- %

nCluster = size(c1_Centers,1);

%% Expected value
m = zeros(size(c1_Centers(1,:)));
for iCluster = 1:nCluster
    m = m + p(iCluster)*c1_Centers(iCluster,:);
end
