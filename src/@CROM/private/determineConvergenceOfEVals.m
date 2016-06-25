function [lambda_l] = determineConvergenceOfEVals(lambda, Ldynamics)
% ------------------------------------- %
% --- determine convergence of P ------ %
% --- from lambda2               ------ %
% --- @created: 2014-02-19 EK --------- %
% ------------------------------------- %

%% Compute entropy
l = 0:1:Ldynamics;
lambda_l = lambda.^l;





