classdef plotFTLE < handle
    % Class for plotting the evolution of the probability distribution
    properties (Hidden)
        Data
        options
    end
    methods
        function obj = plotFTLE(varargin)           % Constructor
            if length(varargin) < 2
                options_user = struct;
            elseif length(varargin) == 2
                options_user = varargin{2};
            end
            
            obj.Data  = varargin{1};
            
            % Default params
            obj.options.xname = 'time';
            obj.options.yname = 'ftle';
            obj.options.Name  = 'ftle';
            obj.options.L     = 1000;
            setOptions(obj,options_user);
            
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = obj.options.Name;
        end
        
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
        end
        function run(obj,fig_handle)
            plotData(obj.Data,obj.options);
        end
    end
end

function plotData(Data,options)

% ------------------------------------- %
% --- plot FTLE                 ------- %
% --- for different IC          ------- %
% --- @created: 2014-03-08 EK   ------- %
% --- NEEDS REVISION
% ------------------------------------- %

nCluster        = utils.Parameters.instance.parameters.nClusters;
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
TextSize        = utils.Parameters.instance.parameters.TextSize;
FigureHeight    = 2*utils.Parameters.instance.parameters.FigureHeight;
units           = utils.Parameters.instance.parameters.units;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;

Ncase = size(Data.data,1);

%% Get colormap
Mmin = 0;
Mmax = 0.8;
Ncolors = 11;
cmap = createColormap_grey(Mmin,Mmax,Ncolors);
MarkerSize = 3;
%% Plots
box on
semilogx(Data.time,Data.data(1,:),'-','Color','k','LineWidth',1,'MarkerSize',MarkerSize)
hold on
plot([1,max(Data.time)],[0,0],'--k','LineWidth',0.5)
LineStyles = {'--', '-.',':'};
for iCase = 2:Ncase
    semilogx(Data.time,Data.data(iCase,:),LineStyles{iCase-1},'Color','k','LineWidth',LineWidth,'MarkerSize',5)
end
%ylim([0 max(max(Data.data))])
%semilogx(1:options.L,lambda1(3,:),'.-','Color',cmap(3,:),'LineWidth',0.5,'MarkerSize',5)
%semilogx(1:options.L,lambda1(4,:),'-','Color',cmap(4,:),'LineWidth',0.5,'MarkerSize',2)
%semilogx(1:options.L,lambda1(5,:),'--','Color',cmap(5,:),'LineWidth',0.5,'MarkerSize',5)

% labels
xlabel(options.xname, 'Fontsize', TextSize);
ylabel(options.yname, 'Fontsize', TextSize);

% axis
axis([0 options.L 0 max(max(Data.data))]) %max(max(Data.data))
%set(gca,'xTick', [10^0,10^1,10^2,10^3,10^4],'xTickLabel',{'e0','e1','e2','e3','e4'})
set(gca,'xTick', [10^0,10^1,10^2,10^3,10^4])
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);


% print
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 2*FigureHeight 2/3*FigureHeight]);
hold off

end
