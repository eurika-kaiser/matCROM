function plotVector(p,yText,xText,ymin,ymax,cmap)

% ------------------------------------- %
% --- plot a probability vector ------- %
% ----@created: 2013-09-08 EK --------- %
% ------------------------------------- %


%% Variables
nCluster        = size(p,1);
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
TextSize        = utils.Parameters.instance.parameters.TextSize;
FigureHeight    = utils.Parameters.instance.parameters.FigureHeight;
units           = utils.Parameters.instance.parameters.units;
GreyBar         = utils.Parameters.instance.parameters.GreyBar;
LineWidthBox    = utils.Parameters.instance.parameters.LineWidthBox;

if nargin < 6
    cmap = GreyBar;
end

%% Plot
hold on
box on

% plot
if size(p,1) == 1 || size(p,2) == 1
    bar(1:nCluster,p,0.7,'FaceColor',cmap)
elseif size(p,2) > 1
    N = size(p,2);
    cmap = gray(N);
    hArray = bar(1:nCluster,p,0.9);
    for i = 1:N
        set(hArray(i),'FaceColor',cmap(i,:));
        legend_text{i} = ['pk-',num2str(i)];
    end
    legend(legend_text)
end
% labels
xlabel(xText, 'Fontsize', TextSize)
ylabel(yText, 'Fontsize', TextSize)

% axis
axis([0 nCluster+1 ymin ymax]) % 0.15
set(gca,'XTick',[1:1:nCluster])
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidthBox);

% print
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 2*FigureHeight FigureHeight]);
%hold off
