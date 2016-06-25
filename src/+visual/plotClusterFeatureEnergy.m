classdef plotClusterFeatureEnergy < handle
    % ------------------------------------- %
    % --- plot cluster energy          ---- %
    % ----@created 2014-10-04 EK ---------- %
    % ------------------------------------- %
    properties (Hidden)
        Data
        Name
        Data2plot
        Name2plot
        xText
        yText
    end
    methods
        function obj = plotClusterFeatureEnergy(Data, type)           % Constructor
            obj.yText= 'fegy';
            switch type
                case 'feature'
                    obj.Name = 'ClusterFeatureEnergy_feat';
                    obj.xText = 'cluster index';
                    obj.Data  = Data;
                case 'cluster'
                    obj.Name = 'ClusterFeatureEnergy_clust';
                    obj.xText = 'feature index';
                    obj.Data  = Data';
            end
        end
        
        function delete(obj)                     % Destructor
        end
        
        function setIndex(obj,index)
            obj.Name2plot = [obj.Name,'_k',sprintf('%03g',index)];
            obj.Data2plot = obj.Data(:,index);
        end
        function Name = getName(obj)
            Name = obj.Name2plot;
        end
        
        function run(obj,fig_handle)
            ymin        = 0;
            ymax        = max(obj.Data2plot)+0.1*max(obj.Data2plot);
            plotVector(obj.Data2plot,obj.yText,obj.xText,ymin,ymax);
        end
    end
end