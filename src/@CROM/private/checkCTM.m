function  P_TF = checkCTM(P, eps)

% ------------------------------------- %
% --- check CTM              ---------- %
% ----@created 2013-09-26 EK ---------- %
% ------------------------------------- %

%% Parameters
nCluster = size(P,1);

%% Check
if sum(sum(P,1)) == nCluster || sum(sum(P,1))-nCluster<eps
    if utils.Parameters.instance.parameters.verbose
        disp('CHECK: Sum of each column of P equals 1.');
    end
    P_TF = 1;
else
    disp(['WARNING: Sum of each column of P is not equal 1: sum(sum(P,1)) = ',num2str(sum(sum(P,1)))]);
    P_TF = 0;
end
    
