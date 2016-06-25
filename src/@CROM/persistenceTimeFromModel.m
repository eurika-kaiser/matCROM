function [ptau] = persistenceTimeFromModel(P,N)

nCluster = size(P,1);
ptau     = zeros(nCluster,N);
for iN = 0:N
    ptau(:,iN+1) = diag(P).^iN.*(ones(size(diag(P)))-diag(P));
end

end