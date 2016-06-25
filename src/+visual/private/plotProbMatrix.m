function plotProbMatrix(Data, scale, ColorMap, regions)

% ------------------------------------- %
% --- plot cluster transition matrix -- %
% ----@created 2013-09-08 EK ---------- %
% ------------------------------------- %
% --- @Info:
% options: 
% addon = circles or none, 
% scale = linear or log10 or ln or none

nCluster   = size(Data,1);
%nCluster   = utils.Parameters.instance.parameters.nClusters;
FigureBox  = utils.Parameters.instance.parameters.CTM_BoxSize;
MarkerSize = utils.Parameters.instance.parameters.CTM_MarkerSize;
TextSize   = utils.Parameters.instance.parameters.TextSize+2;
units      = utils.Parameters.instance.parameters.units;
rpot       = utils.Parameters.instance.parameters.CTM_rpot;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;


set(gca, 'position', [0.1 0.05 0.8 0.8])
%% Parameters
Nc            = size(ColorMap,1);     % number of colors
BoxLength     = FigureBox/nCluster;   % Size of box for one element 
MarkerSizeMax = MarkerSize*13/nCluster; % for nCluster=10 -> 10, for nCluster=20 -> 5, *8

% ----------------------------------------------------------------------------------------------- %
% --------    Plot of Matrix -------------------------------------------------------------------- %
% ----------------------------------------------------------------------------------------------- %

%% START figure
box on
hold on
colormap(ColorMap);

%% PLOT matrix

switch scale
    case 'linear'
        imagesc(Data);
        Data_min = 10^(-rpot);
        Data_max = 1;
        for iCluster = 1:nCluster
            for jCluster = 1:nCluster
                MarkerScale = max([(rpot+Data(iCluster,jCluster))/rpot,0]);
                if MarkerScale == 0
                    % nix
                else
                    plot(jCluster,iCluster,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5)
                end
            end
        end
        set(gca,'YDir','reverse')    
    case 'log10'
        imagesc(log10(Data));
        Data_min = log10(10^(-rpot));
        Data_max = log10(1);
        for iCluster = 1:nCluster
            for jCluster = 1:nCluster
                MarkerScale = max([(rpot+log10(Data(iCluster,jCluster)))/rpot,0]);
                if MarkerScale == 0
                    % nix
                else
                   plot(jCluster,iCluster,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5)
                end
            end
        end   
        set(gca,'YDir','reverse')     
    case 'ln'
        imagesc(log(Data));
        Data_min = log(10^(-rpot));
        Data_max = log(1);    
        for iCluster = 1:nCluster
            for jCluster = 1:nCluster
                MarkerScale = max([(rpot+log(Data(iCluster,jCluster)))/rpot,0]);
                if MarkerScale == 0
                    % nix
                else
                    plot(jCluster,iCluster,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5)
                end
            end
        end   
        set(gca,'YDir','reverse')          
end

if isempty(regions)==0
    % plot borders of regions
    for iRegions = 1:size(regions,1)
        plot([regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], [regions(iRegions,1)-0.5,regions(iRegions,1)-0.5], '-k', 'LineWidth',1) % horizontal up
        plot([regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], [regions(iRegions,2)+0.5,regions(iRegions,2)+0.5], '-k', 'LineWidth',1) % horizontal below
        plot([regions(iRegions,2)+0.5,regions(iRegions,2)+0.5], [regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], '-k', 'LineWidth',1) % vertical right
        plot([regions(iRegions,1)-0.5,regions(iRegions,1)-0.5], [regions(iRegions,1)-0.5,regions(iRegions,2)+0.5], '-k', 'LineWidth',1) % vertical left
    end
end


%% END figure
caxis([Data_min Data_max])
axis([0.5 nCluster+0.5 0.5 nCluster+0.5])
daspect([1 1 1])
if nCluster <= 10
    set(gca,'xtick',[1:nCluster],'ytick',[1:nCluster],'XAxisLocation','top')
    
    % LATEX
%     % Get tick mark positions
%     yTicks = get(gca,'ytick');
%     xTicks = get(gca, 'xtick');
%     set(gca,'xtick',[],'ytick',[],'XAxisLocation','top')
%     ax = axis; %Get left most x-position
%     HorizontalOffset = 0.1;
%     % Reset the ytick labels in desired font
%     for i = 1:length(yTicks)
%         %Create text box and set appropriate properties
%         text(ax(1) - HorizontalOffset,yTicks(i),['$' num2str( yTicks(i)) '$'], ...
%             'HorizontalAlignment','Right','interpreter', 'latex');   
%     end
%     % Reset the xtick labels in desired font 
%     minY = min(yTicks);
%     verticalOffset = 1;
%     horizontalOffset = 0.3;
%     for xx = 1:length(xTicks)
%         %Create text box and set appropriate properties
%         text(horizontalOffset+xTicks(xx), minY - verticalOffset, ['$' num2str( xTicks(xx)) '$'], ...
%             'HorizontalAlignment','Right','interpreter', 'latex');   
%     end
else
    step = getStepForPlotting(nCluster);
    xTicks = [0:step:nCluster];
    yTicks = [0:step:nCluster];
    set(gca,'xtick',[1,xTicks(2:end)],'ytick',[1,yTicks(2:end)],'XAxisLocation','top')
end
set(gca, 'Fontsize', TextSize,'LineWidth', LineWidth_Box);
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 FigureBox FigureBox]);
hold off

%% Finished
disp(['Finished: Plot of CTM.'])
