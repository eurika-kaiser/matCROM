classdef plotLabels < handle
    % ------------------------------------- %
    % --- plot cluster assignment      ---- %
    % ----@created 2013-09-24 EK       ---- %
    % --- @revised 2014-10-04 EK       ---- %
    % ------------------------------------- %
    properties (Hidden)
        Data
    end
    properties (SetAccess = 'public', GetAccess = 'public')
        Name
    end
    methods
        function obj = plotLabels(Data)           % Constructor
            if isfield(Data,'crossing') == 0
                Data.crossing = [];
            end
            obj.Data = Data; 
            obj.Name = 'c1_Labels';
        end
        
        function delete(obj)                     % Destructor
        end
        
        function setName(obj,Name)
            obj.Name = Name;
        end
        
        function Name = getName(obj)
            Name = obj.Name;
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data.Time,obj.Data.Data,obj.Data.T,obj.Data.crossing);
        end
    end
end


function plotData(t, labels, Tlimits, crossing)

%% Parameters

LineWidth       = utils.Parameters.instance.parameters.LineWidth;
TextSize        = utils.Parameters.instance.parameters.TextSize;
FigureHeight    = 2*utils.Parameters.instance.parameters.FigureHeight;
units           = utils.Parameters.instance.parameters.units;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;

nCluster        = max(labels);
M               = length(labels);

%% Plot labels
box on
plot(t,labels,'-','Color',[0.6 0.6 0.6],'LineWidth',0.5)
hold on
plot(t,labels,'+k','MarkerSize',4,'LineWidth',0.5)

if isempty(crossing) == 0
%Plot vertical lines
for iLabel = 2:M
    for iCrossing = 1:size(crossing,1)
        if (labels(iLabel-1) == crossing(iCrossing,1)) && (labels(iLabel) == crossing(iCrossing,2))
            plot((t(iLabel)+t(iLabel-1))/2*ones(1,20),[0:(nCluster+1)/(2*nCluster-1):nCluster+1],'-k','LineWidth',0.5,'MarkerSize',4);
            disp('Plot line ...')
        elseif (labels(iLabel-1) == crossing(iCrossing,2)) && (labels(iLabel) == crossing(iCrossing,1))
            plot((t(iLabel)+t(iLabel-1))/2*ones(1,20),[0:(nCluster+1)/(2*nCluster-1):nCluster+1],'-k','LineWidth',0.5,'MarkerSize',4);
            disp('Plot line ...')
        end
    end
end
end
xlabel('snapshot', 'Fontsize', TextSize)%time
ylabel('cluster index', 'Fontsize', TextSize)
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 2*FigureHeight FigureHeight]);
if length(Tlimits)==2
    axis([Tlimits(1) Tlimits(2) 0 nCluster+1])
    xticks_vals = [Tlimits(1):10:Tlimits(2)];
else
    axis([0 Tlimits 0 nCluster+1])
    xticks_vals = [0:200:M];
end
set(gca,'YTick',[0:5:nCluster+1],'XTick',xticks_vals)%[0:Tend/5:Tend])
hold off
end