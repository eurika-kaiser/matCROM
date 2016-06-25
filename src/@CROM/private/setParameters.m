function setParameters(varargin)
import utils.*

params_def = getDefaultParameters();
if isempty(varargin) == 1
    params_user = struct;
elseif ischar(varargin{1}) == 1
    % user defined configuration script --> params_user
    if nargin==1
        fprintf(1,'%s\n',varargin{1});
        run(varargin{1})
    end
elseif isstruct(varargin{1}) == 1
    params_user = varargin{1};
else
    disp('ERROR: setParameters: wrong input.')
    return;
end

params = config_input(params_def,params_user);

p = utils.Parameters.instance();
p.parameters = params;

end