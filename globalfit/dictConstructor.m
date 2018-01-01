function dict = dictConstructor(d, varargin)
    % Construct a structure with variable name and value pairs
    if isempty(d)
        dict = {};
    else
        dict = d;
    end
    n_entry = numel(varargin);
    
    if n_entry > 0
        for i = 1:n_entry
            varname = varargin{i}{1};
            varval = varargin{i}{2};
            % Add entries into structure
            evalc(['dict.', varname,' = varval']);
        end
    end

end