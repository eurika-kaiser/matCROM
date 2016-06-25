classdef plotClusterProbMat < handle
    % ------------------------------------- %
    % --- plot cluster assignment      ---- %
    % ----@created 2013-09-24 EK       ---- %
    % --- @revised 2014-10-04 EK       ---- %
    % ------------------------------------- %
    properties (Hidden)
        Name
        Data
        crossing
        Plot
    end
    methods
        function obj = plotClusterProbMat(Data,identifier,crossing)           % Constructor
            obj.Name = 'CTM';
            if nargin < 3
                crossing = [];
            elseif isempty(crossing) == 0
                obj.Name = [obj.Name, '_regions'];
                obj.crossing =  crossing;
            end
            obj.Name = [obj.Name,'_',identifier];
            obj.Data = Data;
            obj.Plot = 'Matrix';
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = obj.Name;
        end
        function setName(obj, Name)
            obj.Name = Name;
        end
        function setColorbar(obj)
            obj.Name = [obj.Name, '_circlebar'];
            obj.Plot = 'colorbar';
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data, obj.Plot, obj.crossing);
        end
    end
end




function plotData(Data,type,crossing)

% ------------------------------------- %
% --- plot cluster prob. matrix    ---- %
% ----@created 2013-09-26 EK ---------- %
% ------------------------------------- %

%% Options/Parameters
% options:
% addon = circles or none,
% scale = linear or log10 or ln or none
%addon = 'circles';
scale = 'log10';
%scale = 'linear';
ColorMap = getColormapForCTM();
ColorMap = vertcat([1 1 1],ColorMap);
if nargin < 3
    crossing = [];
end

%% Plot
switch type
    case 'Matrix'
        plotProbMatrix(Data, scale, ColorMap,crossing);
    case 'colorbar'
        plotProbMatrix_colorbar(Data, scale, ColorMap);
end

end