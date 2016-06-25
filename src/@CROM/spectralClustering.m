function clusters  = spectralClustering(P,nGroups,nEvec)

% Adjacency matrix without self-loops having the weights
% A = T;
% for i = 1:size(A,1)
%     A(i,i) = 0;
% end
%
% % Degree matrix
% D = diag(sum(A,1));
%
% % Build laplacian
% %A = ceil(T); % no self loops
% A = T;
% D = diag(sum(W,1));
% L = D-A;
%
% % Normalize L
% %Ln = D^(-1/2)*(D-A)*D^(-1/2); % Symm
% Ln = D^(-1)*L;

L = P;

% Eig
[eVec,eVal]     = eig(L);
[~,IX]          = sort(diag(eVal),'ascend');
eVec            = eVec(:,IX);

% Init
groups = cell(nGroups,1);
for i = 1:nGroups
    groups{i} = [];
end

% Make Bipartite
% Split at zero or min cut criterion in 1D
% if nGroups == 2
%     for i = 1:size(L,1)
%         if eVec(i,2) < 0
%             groups{1} = [groups{1}, i];
%         elseif eVec(i,2) > 0
%             groups{2} = [groups{2}, i];
%         end
%     end
% else
    if nEvec >= size(eVec,2)
        nEvec = size(eVec,2)-1;
    end
    eigv = [2 nEvec]; % vmin vmax 2:...
    newspace   = eVec(:, eigv(1,1): eigv(1,1)+eigv(1,2)-1);  
    clusteralg = 'kmeans';
    if(strcmp(clusteralg, 'kmeans'))
        clustering = crom2.Kmeans();
        clusters = clustering.run(newspace,nGroups);
    else
        clusters = 1 + (newspace > 0);
    end
end
% end