classdef plotVoronoiDiagram < handle
    % Class for plotting plot2DVoronoiDiagram
    properties (Hidden)
        Data
        options
    end
    methods
        function obj = plotVoronoiDiagram(varargin)           % Constructor
            if length(varargin) < 2
                options_user = struct;
            elseif length(varargin) == 2
                options_user = varargin{2};
            end
            
            obj.Data  = varargin{1};
            
            % Default params
            obj.options.xname = '\gamma_1';%'aR1';
            obj.options.yname = '\gamma_2';%'aR2';
            obj.options.Name  = 'VoronoiDiagram2D';
            obj.options.plot_type = 'standard';
            obj.setOptions(options_user);
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = obj.options.Name;
        end
        
        function setName(obj, Name)
            obj.options.Name = Name;
        end
        
        function setPlotType(obj, Type)
           obj.options.plot_type = Type; 
        end
        
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
        end
        
        function run(obj,fig_handle)
            if strcmp(obj.options.plot_type,'standard');
                plot2DVoronoiDiagram(obj.Data, obj.options);
            elseif strcmp(obj.options.plot_type,'controlled');
                plot2DVoronoiDiagram_controlled(obj.Data, obj.options);
            end
        end
    end
end

