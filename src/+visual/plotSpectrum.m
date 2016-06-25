classdef plotSpectrum < handle
    % Class for plotting the evolution of the probability distribution
    properties(SetAccess=public)  %Hidden()
        Data
        Magn
        options
    end
    methods
        function obj = plotSpectrum(varargin)           % Constructor
            %             if length(varargin) < 2
            %                 options_user = struct;
            %             elseif length(varargin) == 2
            %                 options_user = varargin{2};
            %             end
            
            if  isstruct(varargin{1}) == 1
                obj.Data = varargin{1}.lambda;
                obj.Magn = varargin{1}.magn;
            else
                obj.Data  = varargin{1};
                obj.Magn  = [];
            end
            
            % Default params
            obj.options.xname = '\Re(\lambda )';
            obj.options.yname = '\Im(\lambda )';
            obj.options.cname = 'abs(\lambda )';
            obj.options.Name  = 'lambda';
            obj.options.reverse = 0;
            obj.options.unitcircle = 1;
            %setOptions(obj,options_user);
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = obj.options.Name;
        end
        
        function setName(obj, Name)
            obj.options.Name = Name;
        end
        
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data,obj.options,obj.Magn);
        end
    end
end

function plotData(PeVal,options,eAbs)

% ------------------------------------- %
% --- plot spectrum  ------------------ %
% ----@created: 2013-09-08 EK --------- %
% ------------------------------------- %

%% Parameters
TextSize        = utils.Parameters.instance.parameters.TextSize+2;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
units           = utils.Parameters.instance.parameters.units;
FigureHeight    = utils.Parameters.instance.parameters.FigureHeight;
MarkerSize      = utils.Parameters.instance.parameters.MarkerSize;
BoxSize         = utils.Parameters.instance.parameters.CTM_BoxSize;

xText = options.xname;
yText = options.yname;
cText = options.cname;
%% Plot
hold on
box on
grid on

set(gca,'units','normalized', ...
    'position',[0.25 0.25 0.7 .7]);
% plot evals
Ncolors = 20;
cmap = colormap(flipud(colormap(hot(4*Ncolors))));
cmap = cmap(1:4:end,:);
if isempty(eAbs)
    eAbs_norm = abs(PeVal)./max(abs(PeVal));
else
    eAbs_norm = abs(eAbs)./max(abs(eAbs));
end
% unit circle
Pi = 4*atan(1);
phi = 0:0.001:2*Pi+1;
xdata = real(PeVal);
ydata = imag(PeVal);

if options.unitcircle == 1
    if options.reverse == 1
        plot(imag(exp(1i*phi)),real(exp(1i*phi)),'-k','LineWidth',0.5,'MarkerSize',2)
    else
        plot(real(exp(1i*phi)),imag(exp(1i*phi)),'-k','LineWidth',0.5,'MarkerSize',2)
    end
end

if options.reverse == 1
    for i = length(PeVal):-1:1
        plot(ydata(i),xdata(i),'o','MarkerEdgeColor',[0.2,0.2,0.2],'MarkerFaceColor',cmap(round((Ncolors-1)*eAbs_norm(i)+1),:),'MarkerSize',4,'LineWidth',0.5)
    end
    xmin = min(ydata);
    xmax = max(ydata);
    ymin = min(xdata);
    ymax = max(xdata);
else
    for i = length(PeVal):-1:1
        plot(xdata(i),ydata(i),'o','MarkerEdgeColor',[0.2,0.2,0.2],'MarkerFaceColor',cmap(round((Ncolors-1)*eAbs_norm(i)+1),:),'MarkerSize',4,'LineWidth',0.5)
    end
    xmin = min(xdata);
    xmax = max(xdata);
    ymin = min(ydata);
    ymax = max(ydata);
end
if all(eAbs >= 0) && all(eAbs <= 1)
    cmin = 0;
    cmax = 1;
elseif all(eAbs >= 0) && any(eAbs > 1)
    cmin = 0;
    cmax = max(eAbs);
elseif any(eAbs < 0) && all(eAbs < 1) && all(eAbs > -1)
    cmin = -1;
    cmax = +1;
else
    cmin = min(eAbs);
    cmax = max(eAbs);
end
xmin = -1;
xmax = 1;
ymin = -1;
ymax = 1;

caxis([round(10*cmin)/10 round(10*cmax)/10])
h = colorbar('location','north');
x1=get(gca,'position');
x=get(h,'Position');
%if options.reverse == 1
%    x(1)=0.39;
%    x(2)=0.89; % vert
%else
x(1)=0.4;
x(2)=0.91;%86; % vert
%end
x(3)=0.3;  % length
x(4)=0.023; % height
set(h,'Position',x)
%set(gca,'position',x1)
xticks = [round(10*cmin)/10,round(10*(cmin+(cmax-cmin)/2))/10,round(10*cmax)/10];
for i = 1:length(xticks)
    xticklabel{i} = num2str(xticks(i));
end
set(h,'xtick',xticks, ...
    'xticklabel',xticklabel,'Fontsize',6)

if xText(1) == '$'
    xlabel(xText, 'Fontsize', 6,'Interpreter','latex');
else
    xlabel(h, cText,'Fontsize',6, 'position',[x(1)-0.6 x(2)+0.3])
end



% plot grid
% plot([1 1],[-1.1 1.1],'-k', 'LineWidth', 0.5)
% plot([-1 -1],[-1.1 1.1],'-k', 'LineWidth', 0.5)
% plot([-1.1 1.1],[1 1],'-k', 'LineWidth', 0.5)
% plot([-1.1 1.1],[-1 -1],'-k', 'LineWidth', 0.5)
% plot([0 0 ],[-1.1 1.1],'-k', 'LineWidth', 0.5)
% plot([-1.1 1.1],[0 0],'-k', 'LineWidth', 0.5)

% labels
if xText(1) == '$'
    xlabel(xText, 'Fontsize', TextSize,'Interpreter','latex');
else
    xlabel(xText, 'Fontsize', TextSize);
end
if yText(1) == '$'
    ylabel(yText, 'Fontsize', TextSize,'Interpreter','latex');
else
    ylabel(yText, 'Fontsize', TextSize);
end

% axis
%axis equal
dx = xmax-xmin;
dy = ymax- ymin;
axis([xmin-0.1*dx xmax+0.1*dx ymin-0.1*dy ymax+0.2*dy])
%axis equal
%axis([-1.1 1.1 -1.1 1.1])
%axis([0.2,1.01,-0.4,0.4])
%set(gca,'xTick', [0.2,1], 'yTick', [-0.4,0.4])
set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 BoxSize BoxSize]);  %[0 0 3000 3000]
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);

hold off

end
