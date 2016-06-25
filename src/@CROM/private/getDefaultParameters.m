function params = getDefaultParameters

%  Cluster analysis parameters
params.nClusters      	    = 10;
params.nRepetitions         = 1;
params.optimalClustering    = 'sparsity';
params.nIterations          = 1000;
params.distmetric           = 'sqeuclidean';

%  Transition matrix parameters
params.ClusterOrdering      ='transitions';

% N-D approximation of data that preserves distances (for plotting mainly)
params.rDim                 = 2;
params.rVec                 = [1,2];

% Evolution/ Convergence
params.powerL               = 1000;
params.powerLmat            = 20;

%  Optimization parameters

% Paths
params.path2save            = 'output/';

% Plotting
params.GreyBar              = [0.6,0.6,0.6];
params.LineWidth            = 0.5;
params.TextSize             = 8;
params.dpi_r                = 150;
params.FigureHeight         = 2.5;
params.units                = 'centimeters';
params.LineWidthBox         = 0.5;
params.CTM_MarkerSize       = 9;
params.CTM_BoxSize          = 6;
params.CTM_rpot             = 3;
params.MarkerSize           = 3;

% Additional settings
params.save    = 1;
params.verbose = 1;
params.plot    = 1;
params.show    = 0;

end
