function plot2DVoronoiDiagram(Data, options)

% ------------------------------------- %
% --- plot a representation of      --- %
% --- the data in R^n, n=rDim       --- %
% --- @created: 2013-09-26 EK       --- %
% --- @revised: 2013-10-03 EK       --- %
% --- @revised: 2013-10-07 EK       --- %
% --- @revised: 2014-03-29 EK       --- %
% --- @revised: 2014-06-20 EK       --- %
% --- @revised: 2014-10-10 EK       --- %
% --- @book: Multivariate Analyse-  --- %
% ---      methoden by Andreas Handl--- %
% ------------------------------------- %

ai = Data.data;
c1_Centers = Data.centroids; 
c1_Labels = Data.labels;


set(gca,'position',[0.3 0.3 0.65 0.65])

%% Parameters
% TextSize      = 12;
% LineWidth_Box = 1;
% LineWidth     = 1;
% units         = 'centimeter';
% FigureBox     = 5;

TextSize        = 2*utils.Parameters.instance.parameters.TextSize;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
units           = utils.Parameters.instance.parameters.units;
FigureBox       = 6*utils.Parameters.instance.parameters.FigureHeight;
MarkerSize      = utils.Parameters.instance.parameters.MarkerSize;
BoxSize         = utils.Parameters.instance.parameters.CTM_BoxSize;
dpi_r           = utils.Parameters.instance.parameters.dpi_r;
%nCluster        = utils.Parameters.instance.parameters.nClusters;

% TextSize = 10;
% LineWidth_Box = 1;
% LineWidth     = 1;
% units         = 'centimeter';
% FigureBox     = 10;
% MarkerSize    = 1;
% BoxSize       = 12;
% dpi_r         = 150;
if isempty(c1_Labels)==0
nCluster1     = length(unique(c1_Labels));
if nCluster1  == 2
    nCluster = 2;
else
    nCluster      = size(c1_Centers,1);
    nCluster1     = nCluster;
end
else
    nCluster      = size(c1_Centers,1);
    nCluster1     = nCluster;
end
%TODO nCluster of centroids / labels as option
%nCluster1 = nCluster; % HARDCODED HERE FOR goal clusters
%% Parameters

MarkerSize   = 6;
ColorMap     = getColormapForCTM();
Nc           = size(ColorMap,1);     % number of colors

if isempty(c1_Labels) == 0
if length(unique(c1_Labels)) > 2
    if nCluster1 < nCluster
        CMap         = jet(nCluster);
        step         = floor(nCluster/nCluster1);
        CMap         = CMap(1:step:end,:);
    else
        CMap         = jet(nCluster1);
    end
elseif length(unique(c1_Labels)) == 2
    CMap = [0,0,0;
        1,0,0];
end
else
    CMap         = jet(nCluster);
    step         = floor(nCluster/nCluster1);
    CMap         = CMap(1:step:end,:);
end
% nColor = 2*nCluster;
% set(0,'DefaultAxesColorOrder',jet(nColor));
% CMap = get(gca,'ColorOrder');
% ColorMap = CMap;

%% Delauney
if nCluster>2
    c1_DT = DelaunayTri(c1_Centers(:,1),c1_Centers(:,2));
end

% ----------------------------------------------------------------------------------------------- %
% --------    Plot           -------------------------------------------------------------------- %
% ----------------------------------------------------------------------------------------------- %

%% Figure R^n
hold on
box on

% Set color map
%colormap(ColorMap);
colormap(CMap);

% Determine Axes
% if isempty(ai) == 0
% xMin = min([ai(:,1);c1_Centers(:,1)]);
% xMax = max([ai(:,1);c1_Centers(:,1)]);
% yMin = min([ai(:,2);c1_Centers(:,2)]);
% yMax = max([ai(:,2);c1_Centers(:,2)]);
% else
% xMin = min([c1_Centers(:,1)]);
% xMax = max([c1_Centers(:,1)]);
% yMin = min([c1_Centers(:,2)]);
% yMax = max([c1_Centers(:,2)]);
% end
% dx   = 0.05*(xMax-xMin);
% dy   = 0.05*(yMax-yMin);
% xMin = xMin - dx;
% xMax = xMax + dx;
% yMin = yMin - dy;
% yMax = yMax + dy;

% Determine Axes
xMin = min(min([ai(:,1)]));
xMax = max(max([ai(:,1)]));
yMin = min(min([ai(:,2)]));
yMax = max(max([ai(:,2)]));

dx   = 0.05*(xMax-xMin);
dy   = 0.05*(yMax-yMin);
xMin = xMin - dx;
xMax = xMax + dx;
yMin = yMin - dy;
yMax = yMax + dy;


MarkerSize = 5;
% Plot data points & centroids
if isempty(ai) == 0
%plot(ai(:,1),ai(:,2),'-','Color',[0.7,0.7,0.7],'LineWidth',0.5)
hold on
for iCluster = 1:nCluster1 % MarkerSiye = 3
    plot(ai(c1_Labels==iCluster,1),ai(c1_Labels==iCluster,2),'.','MarkerSize',2*MarkerSize,'MarkerEdgeColor',CMap(iCluster,:),'Color',CMap(iCluster,:),'LineWidth',LineWidth)
end
end

if nCluster1 == nCluster
    if nCluster == 2
        CMap     = zeros(size(c1_Centers,1),3);
    else
        CMap         = CMap;
    end
else
    CMap         = zeros(size(c1_Centers,1),3);
    MarkerSize   = 1;
end

for iCluster = 1:size(c1_Centers,1)
    %plot(c1_Centers(iCluster,1), c1_Centers(iCluster,2),'o','MarkerSize',MarkerSize,'MarkerEdgeColor',CMap(iCluster,:),'MarkerFaceColor',CMap(iCluster,:),'LineWidth',LineWidth);
    h(iCluster) = plot(c1_Centers(iCluster,1), c1_Centers(iCluster,2),'.k','MarkerSize',4*MarkerSize,'LineWidth',LineWidth);
end

% Plot Voronoi diagram
if nCluster>2
    voronoi(c1_DT,'-k','LineWidth',1);
end

if isfield(Data,'labels_txt') == 0
    centroids_txt = [1:size(c1_Centers,1)];
else
    centroids_txt = Data.labels_txt;
end


for iCluster = 1:size(c1_Centers,1)
    %text(c1_Centers(iCluster,1)+0.07*abs(c1_Centers(iCluster,1)), ...
    %    c1_Centers(iCluster,2)+0.07*abs(c1_Centers(iCluster,2)),['c_{',num2str(iCluster),'}'],'FontSize',TextSize);
    text(c1_Centers(iCluster,1)+0.07*abs(c1_Centers(iCluster,1)), ...
        c1_Centers(iCluster,2)+0.07*abs(c1_Centers(iCluster,2)),[num2str(centroids_txt(iCluster))],'FontSize',TextSize-2);
%     if iCluster == 1
%         text(c1_Centers(iCluster,1), c1_Centers(iCluster,2)-0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     elseif iCluster == 3
%         text(c1_Centers(iCluster,1)-0.02, c1_Centers(iCluster,2)+0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     elseif iCluster == 4
%         text(c1_Centers(iCluster,1), c1_Centers(iCluster,2)-0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     elseif iCluster == 5
%         text(c1_Centers(iCluster,1)+0.01, c1_Centers(iCluster,2)-0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     elseif iCluster == 7
%         text(c1_Centers(iCluster,1)-0.01, c1_Centers(iCluster,2)+0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     elseif iCluster == 9
%         text(c1_Centers(iCluster,1)-0.02, c1_Centers(iCluster,2)+0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     elseif iCluster == 10
%         text(c1_Centers(iCluster,1)-0.03, c1_Centers(iCluster,2)-0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     else
%         text(c1_Centers(iCluster,1)-0.02, c1_Centers(iCluster,2)-0.02,['c',num2str(iCluster)],'FontSize',TextSize);
%     end
end
axis([xMin xMax yMin yMax])

set(gca, 'Fontsize', TextSize+2,'LineWidth',LineWidth_Box);
%legend(h,entries,'Location','NorthEastOutside')
% set(gcf, 'PaperUnits', units, ...
%     'PaperPosition', [0 0 2*(FigureBox+0.1*FigureBox) 2*FigureBox]);
set(gcf, 'PaperUnits', units, ...
    'PaperPosition', [0 0 FigureBox+2 FigureBox]);
xlabel(options.xname, 'Fontsize', TextSize+2)
ylabel(options.yname, 'Fontsize', TextSize+2)
%xlabel(['$\',options.xname,'$'],'Interpreter','LaTex', 'Fontsize', TextSize)
%ylabel(['$\',options.yname,'$'],'Interpreter','LaTex', 'Fontsize', TextSize)
end