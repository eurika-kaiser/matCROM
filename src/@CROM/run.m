function run(CROM, varargin)
% run CROM pipeline
% PURPOSE : CROM execution program which executes the main functions and some analysis stuff
% INPUT   : CROM : object of type CROM
% NOTE    : If mode save == 1, writes results into mat files

if isempty(varargin) == 1
    % nix
end

if exist(utils.Parameters.instance.parameters.path2save) ~= 7
    mkdir(utils.Parameters.instance.parameters.path2save);
end

ClusterAnalysis(CROM);

Analysis(CROM);

if utils.Parameters.instance.parameters.plot == 1
    plotResults(CROM);
end
display(CROM);

end