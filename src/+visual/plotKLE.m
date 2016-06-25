classdef plotKLE < handle
    % Class for plotting the evolution of the probability distribution
    properties (Hidden)
        Data
        options
    end
    methods
        function obj = plotKLE(varargin)           % Constructor
            if length(varargin) < 2
                options_user = struct;
            elseif length(varargin) == 2
                options_user = varargin{2};
            end
            
            obj.Data  = varargin{1};
            
            % Default params
            obj.options.xname = 'time';
            obj.options.yname = 'kle';
            obj.options.Name  = 'kle';
            obj.options.L     = 1000;
            setOptions(obj,options_user);
        end
        
        function delete(obj)                     % Destructor
        end
        
        function Name = getName(obj)
            Name = obj.options.Name;
        end
        function setOptions(obj,options)
            obj.options = utils.config_input(obj.options,options);
        end
        
        function run(obj,fig_handle)
            plotData(obj.Data,obj.options);
        end
    end
end

function plotData(Data,options)
% ------------------------------------- %
% --- plot KLE        ----------------- %
% --- @created: 2013-10-11 EK --------- %
% --- @revised: 2014-05-12 EK
% ------------------------------------- %
%% Parameters
KLE = Data.data;
tm  = Data.time;
Tmax= options.L;
if isfield(options,'ymin') == 0
    Ymin = min(KLE);
    Ymax = 0;
else
    Ymin = options.ymin;
    Ymax = options.ymax;
end

TextSize        = utils.Parameters.instance.parameters.TextSize;
LineWidth_Box   = utils.Parameters.instance.parameters.LineWidthBox;
LineWidth       = utils.Parameters.instance.parameters.LineWidth;
units           = utils.Parameters.instance.parameters.units;
FigureHeight    = 2*utils.Parameters.instance.parameters.FigureHeight;

for i = 0:1:floor(log10( utils.Parameters.instance.parameters.powerL ))
    xTickVals(i+1) = 10^i;
end


%% Plot
h = semilogx(tm,KLE,'-k','LineWidth',LineWidth);
hold on
box on

axis([0 Tmax Ymin Ymax])
%set(gca,'XTick',xTickVals,'YTick',yTickVals,'yTickLabel',yTickVals_str)
set(gca, 'Fontsize', TextSize,'LineWidth',LineWidth_Box);
xlabel('time', 'Fontsize', TextSize)
ylabel(['KLE'], 'Fontsize', TextSize)

set(gcf, 'PaperUnits', units, 'PaperPosition', [0 0 2*FigureHeight 2/3*FigureHeight]);
hold off

% %% General
% KLEmin = min(KLE);
% for i = 0:1:floor(log10(Ldynamics))
%     xTickVals(i+1) = 10^i;
% end
%
% KLEmin   = min(KLE);
% KLEnorm  = KLE./KLEmin;
% [KLE90, idx90] = min(abs(KLEnorm - (1-t90)));
% tm = 1:Ldynamics;
%
% disp(['KLE: Iteration for 90% = ', num2str(tm(idx90))])
%
% set(0,'DefaultTextInterpreter','Latex');
% %% Plot
% if min(KLE)<20
%      Ymin = floor(min(KLE)/10)*10;
% else
%     Ymin = -20;
% end
% Ymax = 0;
%
% f = figure('Visible','off');
%
% % plot
% h = semilogx(tm,KLE,'-k','LineWidth',LineWidth);
% hold on
% box on
%
% % plot 90%
% %plot([tm(idx90),tm(idx90)],[-10^(2), KLE(idx90)],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% %plot([10^0,tm(idx90)],[KLE(idx90), KLE(idx90)],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% semilogx([tm(idx90),tm(idx90)],[Ymin, KLE(idx90)],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% semilogx([10^0,tm(idx90)],[KLE(idx90), KLE(idx90)],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% %text(tm(idx90)+4,Ymin+1,['l_{90}=',num2str(idx90)],'Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.5*10^0,KLE(idx90)-1,'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% text(tm(idx90),KLE(idx90)-1, ...
%     [' $\leftarrow (l_{',num2str(100*t90),'}=', num2str(tm(idx90)), ', H_{',num2str(100*t90),'}=', num2str(round(10*KLE(idx90))/10) ,')$'], ...
%     'Color',[0.3 0.3 0.3],'FontSize',TextSize)
%
%
%
%
% % Cyl2u M
% %text(tm(idx90),-3*10^(2),'l_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.8*10^0,KLE(idx90-10),'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
% % Cyl LDynamics/10
% %text(tm(idx90),-3*10^(2),'l_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.65*10^0,KLE(idx90-10),'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
% %text(tm(idx90-10),-3*10^(2),'l_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.65*10^0,KLE(idx90-30),'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
% yTickVals = Ymin:(Ymax-Ymin)/2:Ymax;
%
% axis([0 Tmax Ymin Ymax])
% for i = 1:length(yTickVals)
%     yTickVals_str{i} = num2str(yTickVals(i));
% end
%
% set(gca,'XTick',xTickVals,'YTick',yTickVals,'yTickLabel',yTickVals_str)
% %set(gca,'YTick',yTickVals)
% set(gca, 'Fontsize', TextSize,'LineWidth',1);
% xlabel('$l$', 'Fontsize', TextSize)
% if strcmp(prior_txt,'Pinf')
%     y_prior_txt = '{\bf P}^{\infty}';
% else
%     y_prior_txt = ['{\bf ', prior_txt,'}'];
% end
% ylabel(['$H({\bf P}^l,' ,y_prior_txt,')$'], 'Fontsize', TextSize)
%
% % plot
% set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 FigureLength FigureHeight]);%FigureHeight]
% hold off
% file_str = [pathSave,'KLE_',prior_txt,'_Tmax',num2str(Tmax), '_H',num2str(100*t90)];
% print(f,'-dpng',file_str);
% print(f,'-depsc2',sprintf('-r%d',dpi_r),'-cmyk',file_str);
% close(f)
%
%
% %% Plot 2
%
% imax = 2;
% imin = -2;
% if min(abs(KLE)) < 10^(-2)
%     imin = floor(log10(min(abs(KLE))));
% end
% Ymin = 10^(imin);
% if max(abs(KLE)) > 10^(2)
%     imax = ceil(log10(max(abs(KLE))));
% end
% Ymax = 10^(imax);
%
% for i = imin:1:imax
%     yTickVals(i-imin+1) = 10^(i);
%     yTickVals_str{i-imin+1}  = ['$',num2str(10^(i)),'$'];
% end
%
%
% f = figure('Visible','off');
% % plot
% h = loglog(tm,abs(KLE),'-k','LineWidth',LineWidth);
% hold on
% box on
%
% text(tm(idx90),abs(KLE(idx90)), ...
%     [' $\leftarrow (l_{',num2str(100*t90),'}=', num2str(tm(idx90)), ', H_{',num2str(100*t90),'}=', num2str(round(10*KLE(idx90))/10) ,')$'], ...
%     'Color',[0.3 0.3 0.3],'FontSize',TextSize)
%
% % plot 90%
% %plot([tm(idx90),tm(idx90)],[-10^(2), KLE(idx90)],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% %plot([10^0,tm(idx90)],[KLE(idx90), KLE(idx90)],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% loglog([tm(idx90),tm(idx90)],[Ymin, abs(KLE(idx90))],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% loglog([10^0,tm(idx90)],[abs(KLE(idx90)), abs(KLE(idx90))],'--','Color',[0.6 0.6 0.6],'LineWidth',LineWidth);
% %text(tm(idx90)+4,Ymin+1,['l_{90}=',num2str(idx90)],'Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.5*10^0,KLE(idx90)-1,'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
%
%
%
% % Cyl2u M
% %text(tm(idx90),-3*10^(2),'l_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.8*10^0,KLE(idx90-10),'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
% % Cyl LDynamics/10
% %text(tm(idx90),-3*10^(2),'l_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.65*10^0,KLE(idx90-10),'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
% %text(tm(idx90-10),-3*10^(2),'l_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
% %text(0.65*10^0,KLE(idx90-30),'H_{90}','Color',[0.3 0.3 0.3],'FontSize',TextSize-2)
%
%
% axis([0 Tmax Ymin Ymax])
%
% set(gca,'XTick',xTickVals,'YTick',yTickVals(1:2:end))%,'yTickLabel',yTickVals_str(1:2:end))
% set(gca, 'Fontsize', TextSize,'LineWidth',1);
% xlabel('$l$', 'Fontsize', TextSize)
% if strcmp(prior_txt,'Pinf')
%     y_prior_txt = '{\bf P}^{\infty}';
% else
%     y_prior_txt = ['{\bf ', prior_txt,'}'];
% end
% ylabel(['$\vert H({\bf P}^l, ',y_prior_txt,')\vert$'], 'Fontsize', TextSize)
%
% % plot
% set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 FigureLength FigureHeight]);%]
% hold off
% file_str = [pathSave,'KLE_',prior_txt,'_abs_Tmax',num2str(Tmax), '_H', num2str(100*t90)];
% print(f,'-dpng',file_str);
% print(f,'-depsc2',sprintf('-r%d',dpi_r),'-cmyk',file_str);
% close(f)
end