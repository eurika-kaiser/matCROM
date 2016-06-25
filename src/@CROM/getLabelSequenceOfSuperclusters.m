function g1_Labels = getLabelSequenceOfSuperclusters(Labels, groups, Val)
% Calculate the labels for groups
% Input:  Labels - e.g. obtained from CROM
%         groups - cell of length nGroups; each cell containing the cluster index in this group 
%         Val    - array of length nGroups containing the index of the corresponding groups
% Output: labels_groups - labels of the times series (Labels) for the nGroups

if nargin < 3
    Val = 1:length(groups);
end

nGroups         = length(groups);
g1_Labels   = zeros(size(Labels));
for i=1:length(Labels)
    for j = 1:nGroups
        if any(groups{j}(:) == Labels(i))
            g1_Labels(i) = Val(j);
        end
    end
end


end