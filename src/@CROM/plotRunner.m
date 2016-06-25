function plotRunner(plotThisClass)

if utils.Parameters.instance.parameters.show == 1
    f = figure('visible','on');
elseif utils.Parameters.instance.parameters.show == 0 
    f = figure('visible','off'); % off
end

plotThisClass.run(f);
drawnow

if utils.Parameters.instance.parameters.save == 1
    filename = plotThisClass.getName();
    %pathSave = 'output/';
    pathSave = utils.Parameters.instance.parameters.path2save;
    file_str = [pathSave, filename];
    dpi_r    = utils.Parameters.instance.parameters.dpi_r;
    %dpi_r  = 150;
    print(f,'-dpng',file_str);
    print(f,'-depsc2',sprintf('-r%d',dpi_r),file_str); %,'-cmyk',file_str
    utils.plotPDFfigs(f,file_str);
%     print(f,'-dpdf',  file_str);
%     system(['pdfcrop ', file_str, '.pdf ', file_str, '.pdf']);
end

if utils.Parameters.instance.parameters.show == 1
    % nix
elseif utils.Parameters.instance.parameters.show == 0 
    close(f);
end 
    
end