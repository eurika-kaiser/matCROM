classdef plotClusterRMS < handle
    % ------------------------------------- %
    % --- plot cluster rms             ---- %
    % ----@created 2013-12-07 EK ---------- %
    % --- @revised 2014-10-04 EK       ---- %
    % ------------------------------------- %
    properties (Hidden)
        Data
    end
    methods
        function obj = plotClusterRMS(Data)           % Constructor
            obj.Data = Data;
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = 'ClusterRMS';
        end
        
        function run(obj,fig_handle)
            yText       = 'rms';
            xText       = 'cluster index';
            ymin        = 0;
            ymax        = max(obj.Data)+0.1*max(obj.Data);
            
            plotVector(obj.Data,yText,xText,ymin,ymax);
        end
    end
end