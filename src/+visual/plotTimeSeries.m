classdef plotTimeSeries < handle
    % ------------------------------------- %
    % --- plot cluster assignment      ---- %
    % ----@created 2013-09-24 EK       ---- %
    % --- @revised 2014-10-04 EK       ---- %
    % ------------------------------------- %
    properties (Hidden)
        Data
        Time
        options
        Data2plot
    end
    methods
        function obj = plotTimeSeries(varargin)           % Constructor
            if length(varargin) < 2
                options = struct;
            elseif length(varargin) == 2
                options = varargin{2};
            end
            obj.Data             = varargin{1};
            obj.Data2plot        = obj.Data;
            
            % Default parameters
            obj.options.Name = 'TS';
            obj.options.ylim = [];
            obj.options.xlim = [];
            obj.options.xname = 't';
            obj.options.yname = 'variable';
            obj.options.plotLim = 'minmax';
            obj.options.plotylog = 0;
            
            setOptions(obj,options);
            
        end
        
        function delete(obj)                     % Destructor
        end
        
        function setIndex(obj,index)
            obj.options.Name2plot = [obj.options.Name,'_k',sprintf('%03g',index)];
            obj.Data2plot.data    = obj.Data.data(:,index);
        end
        
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
        end
        
        function setName(obj, name)
            obj.options.Name = name;
            obj.options.Name2plot = name;
        end
        
        function Name = getName(obj)
            Name = obj.options.Name;
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data2plot,obj.options);
        end
    end
end


function plotData(Data,  options)
    
if isfield(Data, 'labels') == 1
    plotTimeSeriesClustered(Data, options);
else
    plotTimeSeries(Data, options);
end


end