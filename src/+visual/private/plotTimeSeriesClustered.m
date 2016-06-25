function plotTimeSeriesClustered(Data, options)

% ------------------------------------- %
% --- @created: 2013-12-05 EK       --- %
% ------------------------------------- %
data = Data.data;
t    = Data.time;
c1_Labels = Data.labels;

%% Parameters
nCluster        = utils.Parameters.instance.parameters.nClusters;
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
TextSize        = utils.Parameters.instance.parameters.TextSize;
FigureHeight    = 2*utils.Parameters.instance.parameters.FigureHeight;
units           = utils.Parameters.instance.parameters.units;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;
M               = length(t);

if isempty(options.ylim) == 1 && strcmp(options.plotLim,'maxmax')
    aimax = max(max(data));
    aimin = min(min(data));
    aimax  = max([abs(aimax),abs(aimin)]);
    aimin = - aimax; 
elseif isempty(options.ylim) == 1 && strcmp(options.plotLim,'minmax')
    aimax = max(max(data));
    aimin = min(min(data));   
else
    aimax = options.ylim(2);
    aimin = options.ylim(1);
end

if isempty(options.xlim) == 1
    xs_idx = 1;
    xe_idx = length(t);
else
    xs_idx = options.xlim(1);
    xe_idx = options.xlim(2);
end


%% Parameters
ColorMap     = getColormapForCTM();
Nc           = size(ColorMap,1);     % number of colors
MarkerSize   = 4; 
CMap         = jet(nCluster);
% ----------------------------------------------------------------------------------------------- %
% --------    Plot           -------------------------------------------------------------------- %
% ----------------------------------------------------------------------------------------------- %


%% Figure R^n
hold on
box on
colormap(ColorMap);

plot(t, data,'-','Color',[0.6,0.6,0.6],'LineWidth',0.5);
xlabel(options.xname, 'Fontsize', TextSize)
ylabel(options.yname, 'Fontsize', TextSize)

xMax = determineAxisLimits(data);
for iCluster = 1:nCluster
    m_idx = find(c1_Labels==iCluster);
    h(iCluster) = plot(t(m_idx), data(m_idx),'.','MarkerSize',3,'MarkerEdgeColor',CMap(iCluster,:),'Color',CMap(iCluster,:));
    entries{iCluster} = ['c-',sprintf('%02g',iCluster)];
end
axis([t(xs_idx) t(xe_idx) aimin aimax])

%leg_handle = legend(h,entries,'Location','northoutside','FontSize',7);%[0.85 0.5 0.01 0.01],
% x1=get(gca,'position');
% x=get(leg_handle,'Position');
% % %x(1)=0.7;  % x pos
% % %x(2)=0.2;  % y pos
% x(3)=0.001;  % length/ width x direction
% x(4)=0.004; % height
% set(leg_handle,'Position',x)



%daspect([1 1 1])
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);
set(gcf, 'PaperUnits', units, ...
         'PaperPosition', [0 0 2*FigureHeight 2/3*FigureHeight]);
hold off




