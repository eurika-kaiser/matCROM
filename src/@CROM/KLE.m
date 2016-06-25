function [KLE, KLE_err] = KLE(P, Q, Ldynamics)
% ------------------------------------- %
% --- determine KLE   ----------------- %
% --- @created: 2013-10-11 EK --------- %
% --- @revised: 2014-02-11 EK norm. err %
% ------------------------------------- %

%% Global variables
nCluster = size(P,1);

%% Compute entropy
for t = 1:Ldynamics
    Pt = P^t;
    for iCluster = 1:nCluster
        for jCluster = 1:nCluster
            if Pt(iCluster,jCluster)==0
                KLEtmp(iCluster,jCluster) = 0;
            else
                KLEtmp(iCluster,jCluster) = Pt(iCluster,jCluster)*log(Pt(iCluster,jCluster)/Q(iCluster,jCluster));
            end
        end
    end
    KLE(t) = -sum(sum(KLEtmp));
end

%% Computer error
for iCluster = 1:nCluster
    for jCluster = 1:nCluster
        if Q(iCluster,jCluster)==0
            KLEtmp(iCluster,jCluster) = 0;
        else
            KLEtmp(iCluster,jCluster) = Q(iCluster,jCluster)*log(Q(iCluster,jCluster));
        end
    end
end
KLE_Q = -sum(sum(KLEtmp));
KLE_err = (KLE(end)-KLE_Q)/KLE_Q;



