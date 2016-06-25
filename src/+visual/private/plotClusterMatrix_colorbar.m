function plotClusterMatrix_colorbar(D, ColorMap, caxislim, yText)

nCluster = size(D,1);
%nCluster   = utils.Parameters.instance.parameters.nClusters;
FigureBox  = utils.Parameters.instance.parameters.CTM_BoxSize;
MarkerSize = utils.Parameters.instance.parameters.CTM_MarkerSize;
TextSize   = utils.Parameters.instance.parameters.TextSize;
units      = utils.Parameters.instance.parameters.units;
rpot       = utils.Parameters.instance.parameters.CTM_rpot;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;

Data_min = caxislim(1);
Data_max = caxislim(2);
Nc            = size(ColorMap,1);     % number of colors
MarkerSizeMax = MarkerSize*12/nCluster;% for nCluster=10 -> 10, for nCluster=20 -> 5
ColorMap      = vertcat([1 1 1],ColorMap);

%% Plot circle bar
hold on
box on
colormap(ColorMap)
% plot
if nCluster <= 50
    plotColors = [caxislim(1):(caxislim(2)-caxislim(1))/(nCluster-1):caxislim(2)];
    Dskala = caxislim(1):(caxislim(2)-caxislim(1))/(nCluster-1):caxislim(2);
    range = 1:3:nCluster;
    axis([0.5 0.5+nCluster 0.5 1.5])
else
    plotColors = [caxislim(1):(caxislim(2)-caxislim(1))/(nCluster/10-1):caxislim(2)];
    Dskala = caxislim(1):(caxislim(2)-caxislim(1))/(nCluster/10-1):caxislim(2);
    range = 1:3:nCluster/10;
    axis([0.5 0.5+nCluster/10 0.5 1.5])
end
imagesc(plotColors,caxislim);
Dskala = round(100*Dskala)./100;
if nCluster < 50
    for iCluster = 1:nCluster
        MarkerScale = max([Dskala(iCluster)/Data_max,0]);
        if MarkerScale == 0
            %nix
        else
            plot(iCluster,1,'ok','MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5)
        end
    end
end

% axis
daspect([1 1 1])
set(gca,'xtick',range,'xticklabel',Dskala(range),'ytick',[], 'Fontsize',TextSize) %,plotColors(2:2:end),
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);
%ylabel(yText,'FontSize',TextSize);
text(-0.5,1,yText,'Fontsize', TextSize)
% Misc
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 FigureBox FigureBox/4.1]);
hold off
