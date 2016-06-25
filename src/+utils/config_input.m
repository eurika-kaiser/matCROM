function params_def = config_input(params_def,varargin)

    if isempty(varargin) == 1
        params_in = [];
        return;
    else
        params_in = varargin{:};
    end

    names = fieldnames(params_in);
    for ii = 1:length(names)
        %params_def = setfield(params_def, names{ii}, getfield(params_in, names{ii})); % alternativ
        params_def.(names{ii}) = params_in.(names{ii});
    end

end