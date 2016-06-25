classdef plotClusterMatrix < handle
    % ------------------------------------- %
    % --- plot matrix                  ---- %
    % ----@created 2013-09-24 EK       ---- %
    % --- @revised 2014-10-04 EK       ---- %
    % ------------------------------------- %
    properties (SetAccess = public, GetAccess = public)
        Name
        Data
        crossing
        Plot
        caxislim
        yText
        options
    end
    methods
        function obj = plotClusterMatrix(varargin)           % Constructor
            if length(varargin) < 2
                options_user = struct;
            elseif length(varargin) == 2
                options_user = varargin{2};
            end
            
            % set default
            obj.options.yText = 'djk';
            obj.options.crossing = [];
            obj.options.identifier = 'D';
            
            obj.setOptions(options_user);
            
            
            obj.Name  = obj.options.identifier;
            obj.yText = obj.options.yText;
           
            if isfield(obj.options, 'crossing') == 1
                obj.Name = [obj.Name, '_regions'];
            end
            obj.Data = varargin{1};
            obj.Plot = 'Matrix';
            
            % set axis
            if any(obj.Data<0)
                obj.caxislim = [min(min(obj.Data)), max(max(obj.Data))];
            else
                obj.caxislim = [0, max(max(obj.Data))];
            end
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = obj.Name;
        end
        
        function setName(obj,Name)
            obj.options.identifier = Name;
            obj.Name = obj.options.identifier;
        end
        
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
            obj.yText   = obj.options.yText;
        end
        function setColorbar(obj)
            obj.Name = [obj.Name, '_circlebar'];
            obj.Plot = 'colorbar';
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data, obj.Plot, obj.caxislim, obj.yText, obj.crossing);
        end
    end
end


function plotData(Data,type,caxislim,yText,crossing)

%% Options/Parameters
% options:
% addon = circles or none,
% scale = linear or log10 or ln or none
%addon = 'circles';

ColorMap = getColormapForCTM();

if nargin < 5
    crossing = [];
end

%% Plot
switch type
    case 'Matrix'
        plotClusterMatrix(Data,  ColorMap,caxislim,crossing);
    case 'colorbar'
        plotClusterMatrix_colorbar(Data, ColorMap, caxislim, yText);
end
end
