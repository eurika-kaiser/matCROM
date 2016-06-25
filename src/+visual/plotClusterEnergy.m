classdef plotClusterEnergy < handle
    % ------------------------------------- %
    % --- plot cluster energy          ---- %
    % ----@created 2014-10-04 EK ---------- %
    % ------------------------------------- %
    properties (Hidden)
        Data
    end
    methods
        function obj = plotClusterEnergy(Data)           % Constructor
            obj.Data = Data;
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = 'ClusterEnergy';
        end
        
        function run(obj,fig_handle)
            yText       = 'energy';
            xText       = 'cluster index';
            ymin        = 0;
            ymax        = max(obj.Data)+0.1*max(obj.Data);
            
            plotVector(obj.Data,yText,xText,ymin,ymax);
        end
    end
end