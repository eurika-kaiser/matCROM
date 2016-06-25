function nComponents = findConnectedGraphComponents(P)
% Still testing!

L = laplacianMatrix(P);
[V,eVals] = eig(L);
[eVals, IX] = sort(diag(eVals),'ascend');
V = V(:,IX);
nComponents = length(eVals(eVals == 0)); % nComponents = multiplicity of lambda=0

end