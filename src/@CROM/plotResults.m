function plotResults(CROM)

Nvar   = size(CROM.Data.ts,2);
if Nvar > 4
    Nvar = 4;
end
yTexts = {'var1', 'var2', 'var3', 'var4'};

% Plot time series
Data.time = CROM.Data.t;
Data.data = CROM.Data.ts;
plotThisClass = visual.plotTimeSeries(Data);
for iTS = 1:Nvar
    options.yname = yTexts{iTS};
    plotThisClass.setOptions(options);
    plotThisClass.setIndex(iTS);
    CROM.plotRunner(plotThisClass);
end
 
% Plot clustered time series
Data.labels   = CROM.c1_Labels;
plotThisClass = visual.plotTimeSeries(Data);
options.Name  = 'TS_clustered';
for iTS = 1:Nvar
    options.yname = yTexts{iTS};
    plotThisClass.setOptions(options);
    plotThisClass.setIndex(iTS);
    CROM.plotRunner(plotThisClass);
end


% Cluster assignment
Data.Data = CROM.c1_Labels;
Data.Time = CROM.Data.t;
Data.T    = max(CROM.t);
plotThisClass = visual.plotLabels(Data); 
CROM.plotRunner(plotThisClass);


% cluster transition matrix
plotThisClass = visual.plotClusterProbMat(CROM.P, 'P',[]); % crossing possible
CROM.plotRunner(plotThisClass);
plotThisClass.setColorbar();
CROM.plotRunner(plotThisClass);

% Cluster centroids distance matrix
plotThisClass = visual.plotClusterMatrix(CROM.D); % crossing possible
CROM.plotRunner(plotThisClass);
plotThisClass.setColorbar();
CROM.plotRunner(plotThisClass);

% Diameter
plotThisClass = visual.plotClusterDiameter(CROM.ClusterDiameter);
CROM.plotRunner(plotThisClass);

% RMS
plotThisClass = visual.plotClusterRMS(CROM.ClusterRMS);
CROM.plotRunner(plotThisClass);

% Feature energy per cluster
% plotThisClass = visual.plotClusterFeatureEnergy(CROM.ClusterFeatureEnergy,'cluster');
% for iCluster = 1:utils.Parameters.instance.parameters.nClusters
%     plotThisClass.setIndex(iCluster);
%     CROM.plotRunner(plotThisClass);
% end

% Energy per feature
plotThisClass = visual.plotClusterFeatureEnergy(CROM.ClusterFeatureEnergy,'feature');
for iFeature = 1:2
    plotThisClass.setIndex(iFeature);
    CROM.plotRunner(plotThisClass);
end

% Evolution of probability distribution
Data.data = CROM.pl;
Data.time = [0:length(CROM.pl{1})];
plotThisClass = visual.plotEvolutionOfProbability(Data);
for iCluster = 1:length(CROM.pl)
     plotThisClass.setIndex(iCluster);
     CROM.plotRunner(plotThisClass);
end

% FTLE
Data.data = CROM.ftle;
Data.time = [0:CROM.Data.dt:CROM.Data.dt*(length(CROM.ftle)-1)];
plotThisClass = visual.plotFTLE(Data);
CROM.plotRunner(plotThisClass);

% KLE
Data.data = CROM.kle;
Data.time = [0:CROM.Data.dt:CROM.Data.dt*(length(CROM.kle)-1)];
plotThisClass = visual.plotKLE(Data);
CROM.plotRunner(plotThisClass);

% Spectrum
plotThisClass = visual.plotSpectrum(CROM.lambda);
CROM.plotRunner(plotThisClass);

% Voronoi diagram
clear Data
Data.data       = CROM.ts_r;
Data.labels     = CROM.c1_Labels;
Data.centroids  = CROM.c1_Centroids_r;
plotThisClass   = visual.plotVoronoiDiagram(Data);
CROM.plotRunner(plotThisClass);

% Evolution of CTM
for i = 1:size(CROM.Pl,3)
    plotThisClass = visual.plotClusterProbMat(CROM.Pl(:,:,i), ['Pl_',sprintf('%02g',i)],[]); % crossing possible
    CROM.plotRunner(plotThisClass);
end

% % Expected value
% clear Data options
% for iCluster = 1:utils.Parameters.instance.parameters.nClusters
%     Data.data = CROM.expectedValue{iCluster};
%     Data.time = [0:CROM.Data.dt:CROM.Data.dt*(length(CROM.expectedValue{iCluster}(:,1))-1)];
%     plotThisClass = visual.plotExpectedValue(Data);
%     for i = 1:Nvar
%         options.yname = ['E[',yTexts{i},']']; 
%         options.Name  = ['expVal_k',num2str(iCluster)];
%         plotThisClass.setOptions(options);
%         plotThisClass.setIndex(i); 
%         CROM.plotRunner(plotThisClass);
%     end
% end
end