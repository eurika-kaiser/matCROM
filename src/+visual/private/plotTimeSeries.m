function plotTimeSeries(Data,  options)
    
% ------------------------------------- %
% --- plot time series of data -------- %
% ----@created 2013-10-03 EK ---------- %
% ----@revised 2014-10-04 EK ---------- %
% ------------------------------------- %
data = Data.data;
t    = Data.time;

%% Parameters
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
TextSize        = utils.Parameters.instance.parameters.TextSize+2;
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


%% Plot
hold on
box on

% plot
plot(t,data,'-k','LineWidth',LineWidth)
if options.plotylog == 1
    set(gca,'yscale','log')
end
xlabel(options.xname, 'Fontsize', TextSize)
ylabel(options.yname, 'Fontsize', TextSize)

% axis
axis([t(xs_idx) t(xe_idx) aimin aimax])
%axis tight

%set(gca,'XTick',[0:M/10:M])
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);

% print
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 2*FigureHeight 2/3*FigureHeight]);
hold off
end