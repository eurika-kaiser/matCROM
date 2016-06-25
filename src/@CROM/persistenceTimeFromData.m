function [tau,ptau,histogram,buckets] = persistenceTimeFromData(c1_Labels)

nCluster = length(unique(c1_Labels));
M = length(c1_Labels);
for iC = 1:nCluster
    iTau = 0;
    TF = (c1_Labels == iC);
    m = 1;
    while m<M
        while TF(m) == 0 && m<M
            m = m + 1;
        end
        if TF(m) == 1
            tau{iC}(iTau+1,1) = m;
            while TF(m) == 1 && m<M
                m = m+1; 
            end
            tau{iC}(iTau+1,2) = m;
            iTau = iTau + 1;
        end  
    end
end

% Determine number of consecutive snapshots in a cluster
for iC = 1:nCluster
   tau{iC}(:,3) = tau{iC}(:,2) - tau{iC}(:,1); 
end

% Check
sumM = 0;
for iC = 1:nCluster
   sumM = sumM + sum(tau{iC}(:,3)); 
end

% Determine probability of having N consecutive snapshots in a particular cluster 
for iC = 1:nCluster
    Nmax(iC) = max(tau{iC}(:,3));  
end
Nmax = max(Nmax); % number of transitions
ptau = zeros(nCluster,Nmax);

% Buckets
buckets = zeros(nCluster,Nmax);
seq_length = 1;
cluster = c1_Labels(1);
for m = 2:M
    if c1_Labels(m) == cluster
       seq_length = seq_length + 1;
    else
        buckets(cluster,seq_length) = buckets(cluster,seq_length) + 1;
        seq_length = 1;
        cluster = c1_Labels(m);
    end
end
buckets(cluster,seq_length) = buckets(cluster,seq_length) + 1;

% Check
summe = 0;
for iN = 1:size(buckets,2);
    summe = summe + sum(buckets(:,iN).*iN);
end
if summe ~= M
    disp('ERROR: Not consistent.')
    return;
end

% Histogram
histogram = zeros(size(buckets));
for iN = 1:size(histogram,2)
    for jN = iN:size(histogram,2) 
        histogram(:,iN) = histogram(:,iN) + (jN-iN+1)*buckets(:,jN);
    end
end

% Check
summe = 0;
summe = sum(histogram(:,1));
if summe ~= M
    disp('ERROR: Not consistent.')
    return;
end

% Frequency of sequences ending at another cluster for L+1
histogram_seq = zeros(size(buckets));
for iN = 1:size(histogram_seq,2)
    for jN = iN:size(histogram_seq,2) 
        histogram_seq(:,iN) = histogram_seq(:,iN) + buckets(:,jN);
    end
end

% Check
TF = [];
for iN = 1:Nmax-1
   TF(iN) = all(histogram(:,iN+1)+histogram_seq(:,iN) == histogram(:,iN)); 
end
if all(TF == ones(size(TF))) == 0
    disp('ERROR: Not consistent.')
    return;
end

% Probability
ptau = zeros(size(histogram,1),size(histogram,2)-1);

%ptau(:,1) = histogram_seq(:,1)./(histogram(:,1)); % corresponds to 1 - pkk

for iN = 1:size(histogram_seq,2)
    %ptau(:,iN) = histogram_seq(:,iN)./sum(histogram(:,iN));%(histogram(:,iN));
%     produkt = ones(size(histogram,1),1);
%     for jN = iN:-1:2
%        produkt = produkt .* histogram(:,jN)./histogram(:,jN-1);    
%     end
%     ptau(:,iN) = produkt .* histogram_seq(:,iN)./histogram(:,iN);
    ptau(:,iN) = histogram_seq(:,iN)./histogram(:,1);  % is equal to the other calculations in this loop
end

% for iN = 1:size(histogram_seq,2)
%     ptau(:,iN) = histogram_seq(:,iN)./M;  
% end

% alternative for tests
% ptau = zeros(size(histogram,1),size(histogram,2)-1);
% ptau(:,1) = histogram(:,1)./M; % for transition prob. in 2nd column, 1st col pk
% for iN = 1:size(histogram_seq,2)
%     ptau(:,iN) = histogram(:,iN)./histogram(:,iN-1); % for transition prob. in 2nd column, 1st col pk
% end

end


function TF = findVectorInVector(VecLong, VecShort)
    Nl = length(VecLong);
    Ns = length(VecShort);
    for i = 1:Nl-Ns+1
       TF(i,1) = all(VecLong(i:i+Ns-1) == VecShort);
    end
end

