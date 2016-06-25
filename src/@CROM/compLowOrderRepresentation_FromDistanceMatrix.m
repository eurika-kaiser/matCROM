function [c1_Centers_r] = compLowOrderRepresentation_FromDistanceMatrix(D,rDim,iAlpha)

% ------------------------------------- %
% --- determine a representation of --- %
% --- the CDM in R^n, n=rDim        --- %
% --- @created: 2016-01-18 EK       --- %
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

nCluster = size(D,1);

%% Parameter
eps = 10^(-12); % Fehler

%% Step 1 - Construct A
% Each object is a row vector which corresponds to c1_Centers
% A = (a_ij) = -0.5* D_ij^2
D2 = D.^2;
A  = -0.5 .* D2; 

%% Step 2 - Construct B = (bij) with bij = aij - ai. - a.j + a..
for i = 1:nCluster
    a_idot(i) = 1/nCluster*sum(A(i,:));
    a_dotj(i) = 1/nCluster*sum(A(:,i));
end
a_dotdot = 1/(nCluster^2)*sum(sum(A));
for i = 1:nCluster
    for j = 1:nCluster
        B(i,j) = A(i,j) - a_idot(i) - a_dotj(j) + a_dotdot;
    end
end


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

%% Step 5 - Projection of centroids onto principal components
for i = 1:rDim
    c1_Centers_r(:,i) = sqrt(lambda_r(i)).*V_r(:,i);
end

%% Quality
% First negative eVal
idx = find(lambda<0,1,'first');
disp(['First idx of negative eVal: ', num2str(idx)])
idx = find(lambda==eps,1,'first');
disp(['First idx of eVal=0 : ', num2str(idx)])

alpha1 = sum(lambda_r)/sum(abs(lambda));
disp(['alpha1 = ', num2str(alpha1)])
alpha2 = sum(lambda_r.^2)/sum(lambda.^2);
disp(['alpha2 = ', num2str(alpha2)])



