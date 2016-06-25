function [ai_r,c1_Centers_r] = compLowOrderRepresentation(ai,c1_Centers,rDim,iAlpha)

% ------------------------------------- %
% --- determine a representation of --- %
% --- the CDM in R^n, n=rDim        --- %
% --- @created: 2013-09-26 EK       --- %
% --- @depends:                     --- %
% --- @book: Multivariate Analyse-  --- %
% ---      methoden by Andreas Handl--- %
% ---      POD                      --- %
% ------------------------------------- %
% --- INPUT:
% ---         ai : TxN matrix, feature vectors as rows, i.e. N = #features, T = #timeseries (e.g.)
% --- c1_Centers : KxN matrix, cluster centers, K=#clusters
% ---       rDim : 1x1 scalar, dimension to reduce to, typically = 2
% ---     iAlpha : 1xrDim vector, selection of modes onto which the projection should be done
% --- EXAMPLE: rDim = 2, iAlpha = [1,2] => projection onto first 2 modes
% --- OUTPUT:
% ---       ai_r : TxrDim matrix, ai projected onto the selected/dominant modes
% ---c1_Centers_r: KxrDim matrix, cluster centers projected onto selected/dominant modes



if length(iAlpha) ~= length(rDim)
    rDim = length(iAlpha);
end

nCluster = size(c1_Centers,1);

%% Parameter
eps = 10^(-12); % Fehler


%% Step 1 - Covariance matrix of fluctuations
% B = XX', X has objects as row vectors
c1_Centers_mean = sum(c1_Centers,1)./nCluster;
for iCluster = 1:nCluster
    c1_Centers_fluct(iCluster,:) = squeeze(c1_Centers(iCluster, :)) - c1_Centers_mean;
end
B = c1_Centers_fluct' * c1_Centers_fluct;

%% Step 3 - Spectrum of B
% V: col = eigvec
% D: diag(lambda_i)

[V,Lambda]  = eig(B);
lambda      = diag(Lambda);
[lambda,IX] = sort(lambda,'descend');
V           = V(:,IX);

%% Step 4 - Representation in R^r: first r principal components
lambda_r     = lambda(iAlpha);
V_r          = V(:,iAlpha);
for i = 1:rDim
    pca_vec_r(:,i) = V_r(:,i);
end

%% Step 5 - Projection of centroids onto principal components
c1_Centers_r = c1_Centers * pca_vec_r;

%% Quality
% First negative eVal
if utils.Parameters.instance.parameters.verbose
    idx = find(lambda<0,1,'first');
    disp(['First idx of negative eVal: ', num2str(idx)])
    idx = find(lambda==eps,1,'first');
    disp(['First idx of eVal=0 : ', num2str(idx)])
    
    alpha1 = sum(lambda_r)/sum(abs(lambda));
    disp(['alpha1 = ', num2str(alpha1)])
    alpha2 = sum(lambda_r.^2)/sum(lambda.^2);
    disp(['alpha2 = ', num2str(alpha2)])
end
%% Projection of ai
ai_r = ai*pca_vec_r;


