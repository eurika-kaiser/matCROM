function plotProbMatrix_colorbar(Data, scale, ColorMap)

% ------------------------------------- %
% --- plot cluster transition matrix -- %
% ----@created 2013-09-08 EK ---------- %
% ------------------------------------- %
% --- @Info:
% options:
% addon = circles or none,
% scale = linear or log10 or ln or none

nCluster = size(Data,1);
%nCluster   = utils.Parameters.instance.parameters.nClusters;
FigureBox  = utils.Parameters.instance.parameters.CTM_BoxSize;
MarkerSize = utils.Parameters.instance.parameters.CTM_MarkerSize;
TextSize   = utils.Parameters.instance.parameters.TextSize;
units      = utils.Parameters.instance.parameters.units;
rpot       = utils.Parameters.instance.parameters.CTM_rpot;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;

%% Parameters
Nc          = size(ColorMap,1);     % number of colors
BoxLength   = FigureBox/nCluster;   % Size of box for one element
MarkerSizeMax = MarkerSize*13/nCluster; % for nCluster=10 -> 10, for nCluster=20 -> 5, *8


% ----------------------------------------------------------------------------------------------- %
% --------    Plot of color/circle bar ---------------------------------------------------------- %
% ----------------------------------------------------------------------------------------------- %
switch scale
    case 'linear'
        %imagesc(Data);
        Data_min = 10^(-rpot);
        Data_max = 1;
    case 'log10'
        %imagesc(log10(Data));
        Data_min = log10(10^(-rpot));
        Data_max = log10(1);
    case 'ln'
        %imagesc(log(Data));
        Data_min = log(10^(-rpot));
        Data_max = log(1);
end

%% Plot circle bar
% START figure
hold on
box on
colormap(ColorMap)
plotColors = [Data_min:(Data_max-Data_min)/(nCluster-1):Data_max];
imagesc(plotColors);

% PLOT figure
switch scale
    case 'linear'
        for iCluster = 1:nCluster
            MarkerScale = max([(rpot+plotColors(iCluster))/rpot,0]);
            %disp(['i=',num2str(iCluster), ', pi=',num2str(plotColors(iCluster)), ', scale=',num2str(MarkerScale)]);
            if MarkerScale == 0
                % nix
            else
                plot(iCluster,1,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5);
            end
        end
        % Ticks
        xticks_p(1) = 0;
        for iCluster = 2:nCluster
            xticks_p(iCluster) = plotColors(iCluster);
        end
        for iCluster = 1:nCluster
            if (xticks_p(iCluster))>0.001 && (xticks_p(iCluster))<0.01
                xticks_p(iCluster) = round(1000*xticks_p(iCluster))/1000;
            elseif (xticks_p(iCluster))>0.01 && (xticks_p(iCluster))<0.1
                xticks_p(iCluster) = round(100*xticks_p(iCluster))/100;
            elseif (xticks_p(iCluster))>0.1 && (xticks_p(iCluster))<1
                xticks_p(iCluster) = round(100*xticks_p(iCluster))/100;
            end
        end
    case 'log10'
        for iCluster = 1:nCluster
            MarkerScale = max([(rpot+plotColors(iCluster))/rpot,0]);
            %disp(['i=',num2str(iCluster), ', pi=',num2str(10^(plotColors(iCluster))), ', scale=',num2str(MarkerScale)]);
            if MarkerScale == 0
                % nix
            else
                plot(iCluster,1,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5);
            end
        end
        % Ticks
        xticks_p(1) = 0;
        for iCluster = 2:nCluster
            xticks_p(iCluster) = 10^plotColors(iCluster);
        end
        for iCluster = 1:nCluster
            if (xticks_p(iCluster))>0.001 && (xticks_p(iCluster))<0.01
                xticks_p(iCluster) = round(1000*xticks_p(iCluster))/1000;
            elseif (xticks_p(iCluster))>0.01 && (xticks_p(iCluster))<0.1
                xticks_p(iCluster) = round(100*xticks_p(iCluster))/100;
            elseif (xticks_p(iCluster))>0.1 && (xticks_p(iCluster))<1
                xticks_p(iCluster) = round(100*xticks_p(iCluster))/100;
            end
        end
    case 'ln'
        for iCluster = 1:nCluster
            MarkerScale = max([(rpot+plotColors(iCluster))/rpot,0]);
            %disp(['i=',num2str(iCluster), ', pi=',num2str(exp(plotColors(iCluster))), ', scale=',num2str(MarkerScale)]);
            if MarkerScale == 0
                % nix
            else
                plot(iCluster,1,'ok', 'MarkerSize',MarkerScale*MarkerSizeMax,'LineWidth',0.5);
            end
        end
        % Ticks
        xticks_p(1) = 0;
        for iCluster = 2:nCluster
            xticks_p(iCluster) = exp(plotColors(iCluster));
        end
        for iCluster = 1:nCluster
            if (xticks_p(iCluster))>0.001 && (xticks_p(iCluster))<0.01
                xticks_p(iCluster) = round(1000*xticks_p(iCluster))/1000;
            elseif (xticks_p(iCluster))>0.01 && (xticks_p(iCluster))<0.1
                xticks_p(iCluster) = round(100*xticks_p(iCluster))/100;
            elseif (xticks_p(iCluster))>0.1 && (xticks_p(iCluster))<1
                xticks_p(iCluster) = round(100*xticks_p(iCluster))/100;
            end
        end
end

% END figure
caxis([Data_min Data_max])
axis([0.5 0.5+nCluster 0.5 1.5])
daspect([1 1 1])
ic = 1:3:nCluster;
j = 1;
for i=1:3:nCluster
    xticks_ic(j) = xticks_p(i);
    j = j+1;
end
% if ic(end)~=nCluster
%     ic = [ic, nCluster+1];
%     xticks_ic = [xticks_ic,1];
% end
set(gca,'xtick',ic,'xticklabel',xticks_ic,'ytick',[])
% set(gca,'xtick',[1:nCluster],'xticklabel',[],'ytick',[])
% k=0;
% for i = 1:3:nCluster
%     k = k+1;
%     text(-0.5+i,+2,num2str(xticks_ic(k)),'Fontsize', TextSize)
% end
set(gca,'Fontsize', TextSize,'LineWidth', LineWidth_Box);
%ylabel('pjk','FontSize',TextSize);
%ylabel(['Pjk'],'Fontsize', TextSize)
text(-0.5,1,['Pjk'],'Fontsize', TextSize)
set(get(gca,'YLabel'),'Rotation',0); 
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 FigureBox FigureBox/4]);
hold off


