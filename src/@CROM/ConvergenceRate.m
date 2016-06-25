function ConvergenceRate(CROM)
% 2nd largest eigenvalue of P determines convergence rate of P^l
Ldynamics = utils.Parameters.instance.parameters.powerL;
[CROM.lambda2_ev] = determineConvergenceOfEVals(CROM.lambda(2), Ldynamics);

end