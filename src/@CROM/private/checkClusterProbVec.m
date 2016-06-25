function  q_TF = checkClusterProbVec(q, eps)

% ------------------------------------- %
% --- check cluster prob. vector   ---- %
% ----@created 2013-09-26 EK ---------- %
% ------------------------------------- %

%% Check
if sum(q) == 1 || abs(sum(q)-1)<eps
    if utils.Parameters.instance.parameters.verbose
        disp('CHECK: Sum of q is equal 1.');
    end
    q_TF = 1;
else
    if utils.Parameters.instance.parameters.verbose
        disp(['WARNING: checkClusterProbVec: Sum of q is not equal 1: \sum q = ',num2str(sum(q))]);
    end
    q_TF = 0;
end
    
