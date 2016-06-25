function plotClusterMatrix(D, ColorMap,caxislim,regions)

%% Options
nCluster   = utils.Parameters.instance.parameters.nClusters;
FigureBox  = utils.Parameters.instance.parameters.CTM_BoxSize;
MarkerSize = utils.Parameters.instance.parameters.CTM_MarkerSize;
TextSize   = utils.Parameters.instance.parameters.TextSize;
units      = utils.Parameters.instance.parameters.units;
rpot       = utils.Parameters.instance.parameters.CTM_rpot;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;

if size(D,1) ~= nCluster
    disp('WARNING: Size of matrix ~= Nclusters ... using size of matrix!')
    nCluster = size(D,1);
end

Nc            = size(ColorMap,1);     % number of colors
MarkerSizeMax = MarkerSize*12/nCluster;% for nCluster=10 -> 10, for nCluster=20 -> 5
%ColorMap      = vertcat([1 1 1],ColorMap);
ColorMap  = flipud(gray(50));
%ColorMap   = jet(50);
set(gca, 'position', [0.15 0.025 0.8 0.9])


%% PLOT
hold on
box on
colormap(ColorMap);
% Data
imagesc(D);
Data_min = caxislim(1)
Data_max = caxislim(2)        
% Marker
if nCluster < 50
    for iCluster = 1:nCluster
        for jCluster = 1:nCluster
            MarkerScale = max([(D(iCluster,jCluster))/Data_max,0]);
            if MarkerScale == 0
                %nix
            else
                plot(jCluster,iCluster,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5)
            end
        end
    end
end
if isempty(regions)==0
    % plot borders of regions
    for iRegions = 1:size(regions,1)
        plot([regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], [regions(iRegions,1)-0.5,regions(iRegions,1)-0.5], '-k', 'LineWidth',0.5) % horizontal up
        plot([regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], [regions(iRegions,2)+0.5,regions(iRegions,2)+0.5], '-k', 'LineWidth',0.5) % horizontal below
        plot([regions(iRegions,2)+0.5,regions(iRegions,2)+0.5], [regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], '-k', 'LineWidth',0.5) % vertical right
        plot([regions(iRegions,1)-0.5,regions(iRegions,1)-0.5], [regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], '-k', 'LineWidth',0.5) % vertical left
    end
end

caxis([Data_min Data_max])
axis([0.5 nCluster+0.5 0.5 nCluster+0.5])
daspect([1 1 1])
if nCluster <= 10
    set(gca,'xtick',[1:nCluster],'ytick',[1:nCluster],'XAxisLocation','top')
else
    step = getStepForPlotting(nCluster);
    xTicks = [0:step:nCluster];
    yTicks = [0:step:nCluster];
    set(gca,'xtick',[1,xTicks(2:end)],'ytick',[1,yTicks(2:end)],'XAxisLocation','top')
end
set(gca,'YDir','reverse') % axis reverse      
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);
set(gcf, 'PaperUnits', units, ...
         'PaperPosition', [0 0 FigureBox FigureBox]);
hold off


end
