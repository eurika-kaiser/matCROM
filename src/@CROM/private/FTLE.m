function [lambda1] = FTLE(P,Tend)

% ------------------------------------- %
% --- determine FTLE            ------- %
% --- for different IC          ------- %
% ----@created: 2014-03-08 EK   ------- %
% ------------------------------------- %

nCluster = size(P,1);

%% lambda1 for pi01_vec = [1,0,...], pi02_vec = [0,1,0,...]
% pi01(1,:) = [1, zeros(1,nbCluster-1)];
% pi02(1,:) = [0, 1, zeros(1,nbCluster-2)];
% 
% delta_pi0(1,:) = pi01(1,:)-pi02(1,:);
% -> only NaNs and Infs


%% Compute Lyapunov exponent in dependence of different T, N=10^3 
for iCase = 1:3
    % lambda1 for pi01_vec = rand(1,nbCluster), pi02_vec = rand(1,nbCluster)
    pi01(:,iCase) = rand(nCluster,1);
    pi01(:,iCase) = pi01(:,iCase)./sum(pi01(:,iCase));
    pi02(:,iCase) = rand(nCluster,1);
    pi02(:,iCase) = pi02(:,iCase)./sum(pi02(:,iCase));
    delta_pi0(:,iCase) = abs(pi01(:,iCase)-pi02(:,iCase));
    for T = 1:Tend
        summe = log( norm((P^T*delta_pi0(:,iCase))./delta_pi0(:,iCase)));
        lambda_tmp = 1/T*summe;
        lambda1(iCase,T) = lambda_tmp;
    end
end

%% For condition 1/N
iCase = iCase + 1;
pi01(:,iCase) = ones(nCluster,1)./nCluster;
pi01(:,iCase) = pi01(:,iCase)./sum(pi01(:,iCase));
pi02(:,iCase) = rand(nCluster,1);
pi02(:,iCase) = pi02(:,iCase)./sum(pi02(:,iCase));
delta_pi0(:,iCase) = abs(pi01(:,iCase)-pi02(:,iCase));
for T = 1:Tend
    summe = log( norm( (P^T*delta_pi0(:,iCase))./delta_pi0(:,iCase)));
    lambda_tmp = 1/T*summe;
    lambda1(iCase,T) = lambda_tmp;
end
Ncase = iCase;






