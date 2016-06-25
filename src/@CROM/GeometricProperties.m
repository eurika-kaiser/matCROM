function GeometricProperties(CROM)
CROM.D = determineClusterDistanceMatrix(CROM.c1_Centroids);

CROM.ClusterDiameter        = determineClusterDiameter(CROM.Data.ts,CROM.c1_Labels);
%CROM.ClusterRadius   = determineClusterRadius(CROM.Data.ts,CROM.c1_Labels, CROM.c1_Centroids);
CROM.ClusterRMS             = determineClusterRMS(CROM.Data.ts,CROM.c1_Labels, CROM.c1_Centroids);
%determineClusterVariance.m
CROM.ClusterEnergy          = determineClusterEnergy(CROM.Data.ts, CROM.c1_Labels);
CROM.ClusterFluctEnergy     = determineClusterFluctEnergy(CROM.Data.ts, CROM.c1_Labels);
CROM.ClusterFeatureEnergy   = determineClusterFeatureEnergy(CROM.Data.ts, CROM.c1_Labels);

end