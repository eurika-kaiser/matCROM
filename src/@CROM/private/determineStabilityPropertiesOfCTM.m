function [P_eVal, P_eVec] = determineStabilityPropertiesOfCTM(P)

% ------------------------------------- %
% --- determine stability properties -- %
% ----@created: 2013-09-26 EK --------- %
% ----@revised: 2014-03-08 EK rm norm - %
% ------------------------------------- %

%% Compute eigenvalues & vectors
[eVecArray,eVals]   = eig(P);
[eVals,I]           = sort(diag(eVals),'descend');
eVecArray           = eVecArray(:,I);

%% Return
P_eVal = eVals;
P_eVec = eVecArray;
