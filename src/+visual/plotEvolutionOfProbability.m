classdef plotEvolutionOfProbability < handle
    % Class for plotting the evolution of the probability distribution
    properties (Hidden)
        Data
        Time
        options
        Data2plot
    end
    methods
        function obj = plotEvolutionOfProbability(varargin)           % Constructor
            if length(varargin) < 2
                options_user = struct;
            elseif length(varargin) == 2
                options_user = varargin{2};
            end 
            
            obj.Data            = varargin{1};
            obj.Data2plot.time  = varargin{1}.time;
            obj.Data2plot.data  = varargin{1}.data;
            
            % Default parameters
            obj.options.xname = 'iteration l';
            obj.options.yname = 'pk';
            obj.options.Name  = 'pl';
            obj.options.Ncolors = 2*utils.Parameters.instance.parameters.nClusters;
            obj.options.L       = 100;
            setOptions(obj,options_user);
        end
        
        function delete(obj)                     % Destructor
        end
        
        function setIndex(obj,index)
            obj.options.Name2plot       = [obj.options.Name,'_k',sprintf('%03g',index)];
            obj.Data2plot.data          = obj.Data.data{index};
        end
        
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
        end
        
        function setName(obj, Name)
            obj.options.Name = Name;
            obj.options.Name2plot = Name;
        end
        
        function Name = getName(obj)
            Name = obj.options.Name2plot;
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data2plot,obj.options);
        end
    end
end

function plotData(Data,options)

Ncolors = options.Ncolors;
L       = options.L;
xname   = options.xname;
yname   = options.yname;
t       = Data.time;
if size(Data.data,1) < size(Data.data,2)
    pl      = Data.data;
else
    pl      = Data.data';
end

nCluster        = utils.Parameters.instance.parameters.nClusters;
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
TextSize        = utils.Parameters.instance.parameters.TextSize+2;
FigureHeight    = 2*utils.Parameters.instance.parameters.FigureHeight;
units           = utils.Parameters.instance.parameters.units;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;

set(gca,'position',[0.25 0.3 0.6 0.65])
%% Plot
cmap = flipud(gray(Ncolors));

hold on

% Add log scale
data = log10(pl);

% linear scale
%imagesc(pl),
%caxis([0 1])

imagesc(data)
caxis([-3 0])
colormap(cmap),
box on
h = colorbar('location','eastoutside');
%set(h, 'ylim', [0 1])
set(h, 'ylim', [-4 0], 'ytick', [-4:1:0], 'yticklabel', {'0', '0.001', '0.01', '0.1', '1'})
x1=get(gca,'position');
x=get(h,'Position');
x(1)=0.9;   % x pos
x(2)=0.3;  % y pos
x(3)=0.02;  % length/ width x direction
x(4)=0.65; % height
set(h,'Position',x)
%xlabel(h, 'pk','Fontsize',6)
%xlabh = get(h,'XLabel');
%set(xlabh,'Position',get(xlabh,'Position') + [0 .1 0]) % move xlabel up by 1.2

%axis equal
%daspect([6 1 1])

axis([1 L+1 0.5 nCluster+0.5])
set(gca, 'xlim', [1 L])
set(gca, 'ylim', [1 nCluster])


if isempty(xname)==0
    xlabel(xname,'Fontsize',TextSize)
end
if isempty(yname)==0
    ylabel(yname,'Fontsize',TextSize)
end
box on

set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);
set(gcf, 'PaperUnits', units, ...
    'PaperPosition', [0 0 3/2*FigureHeight 2/3*FigureHeight]);
hold off


end