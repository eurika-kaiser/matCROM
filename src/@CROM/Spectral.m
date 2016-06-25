function Spectral(CROM)

[eVecs,eVals]   = eig(CROM.P);
eVals           = diag(eVals);
[~,IX]          = sort(abs(eVals), 'descend');
eVecs           = eVecs(:,IX);
lambda          = eVals(IX);

CROM.lambda = eVals;
CROM.p1     = eVecs(:,1)./sum(eVecs(:,1));
CROM.eVecs  = eVecs;

% mu = 1/dt*log(lambda)
dt = CROM.Data.dt;
CROM.mu = 1/dt.*log(CROM.lambda); 
end
