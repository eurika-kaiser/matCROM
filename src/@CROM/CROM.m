classdef CROM < handle
    % CROM Class
    % INPUT : {filename} : m-file script with parameters
    %          Dataobject: object with data
    properties (SetAccess = public, GetAccess = public)
        Data % time-series data
        M
        ClusteringResults
        sparsity
        c1_Centroids
        ts_r
        c1_Centroids_r
        c1_Labels
        P            % Cluster transition probability matrix
        D             % Cluster distance matrix
        ClusterDiameter
        ClusterRMS
        ClusterEnergy
        ClusterFluctEnergy
        ClusterFeatureEnergy
        SpectrGap
        lambda
        lambda2_ev
        mu
        eVecs
        p1
        Pl
        pl
        pinf
        expectedValue
        expVal_r
        ftle
        kle
        tau
        d2
        t
        Variance
        q
    end
    
    properties (Dependent = true, SetAccess = private)
    end
    
    methods (Static)
        plotRunner(plotClass);
        [kle,kle_err] = KLE(P, Q, L);
    end
    methods (Hidden)
        function checkProperties(obj)
            keyboard
        end
    end
    
    methods (Access = private)
        setParameters(params_or_filename);
    end
    
    methods(Static)
        A = adjacencyMatrix(P); % check
        D = degreeMatrix(P);    % check
        L = laplacianMatrix(P); % check
        x = pagerank(P,A,p);    % check
        [tau,ptau,histogram,buckets] = persistenceTimeFromData(c1_Labels);
        [ptau] = persistenceTimeFromModel(P,N);
        [MeanClusterFeatures] = meanClusterFeatures(c1_Labels,Features);
        clusters  = spectralClustering(P,nGroups,nEvec);
        chain = generateTimeseriesFromModel(P, Np, IC);
        g1_Labels = getLabelSequenceOfSuperclusters(Labels, groups, Val);
        [ts_r,c1_Centroids_r] = compLowOrderRepresentation(ts,c1_Centroids,rDim,rVec);
        [c1_Centroids_r] = compLowOrderRepresentation_FromDistanceMatrix(D,rDim,rVec);
    end
    methods
        run(obj);                              % Run CROM pipeline
        ClusterAnalysis(obj);
        DTMC(obj);
        %CTMC(obj,option);
        %ApproxND(obj);
        GeometricProperties(obj);
        Spectral(obj);
        ConvergenceRate(obj);
        Dynamics(obj);
        ProjectionInClusterSpace(obj);
        DynamicProperties(obj);
        ModelError(obj);
        Analysis(obj);                          % Contains all calls for the analysis
        display(obj);
        plotResults(obj);
        
        
        function obj = CROM(varargin)           % Constructor
            if not(isempty(varargin))
                if length(varargin) == 2
                    setParameters(varargin{2});
                    obj.Data = varargin{1};
                    obj.M    = size(obj.Data.ts,1);
                elseif length(varargin) == 1
                    if ischar(varargin{1}) == 1
                        setParameters(varargin{1});
                    else
                        obj.Data = varargin{1};
                        obj.M    = size(obj.Data.ts,1);
                    end
                end
            end
            
        end
        
        function delete(obj)                     % Destructor
        end
        
        function clean(obj)
            if exist(utils.Parameters.instance.parameters.path2save) == 7 % is folder
                rmdir(utils.Parameters.instance.parameters.path2save,'s');
                mkdir(utils.Parameters.instance.parameters.path2save);
            else
                mkdir(utils.Parameters.instance.parameters.path2save);
            end
        end
        
        function saveCROM(obj,filename)
            if nargin == 2
%                 file_crom = ['CROM_results_',filename];
%                 file_params = ['CROM_parameters_',filename];
                file_crom = [filename,'_results'];
                file_params = [filename,'_parameters'];
            else
                file_crom = ['CROM_results'];
                file_params = ['CROM_parameters'];
            end
            save(file_crom, 'obj');
            params = utils.Parameters.instance.parameters;
            save(file_params,'params');
        end
        
        function [CROM,Parameters]= loadCROM(obj,name1, name2)
            if nargin < 2
                name1 = 'CROM_results';
                name2 = 'CROM_parameters';
            end
            CROMstruct = load(name1);
            CROM = getfield(CROMstruct, 'obj');
            
            Params_struct = load(name2);
            Parameters = getfield(Params_struct, 'params');
            
            p = utils.Parameters.instance();
            p.parameters = Parameters;
            %obj.
        end
        
    end
    
end


