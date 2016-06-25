function [MeanClusterFeatures] = meanClusterFeatures(c1_Labels,Features)

nCluster = max(c1_Labels);
MeanClusterFeatures = zeros(nCluster,size(Features,2));
for iC = 1:nCluster
   TF = c1_Labels == iC;
   MeanClusterFeatures(iC,:) = sum(Features(TF,:),1)./sum(TF); 
end
end