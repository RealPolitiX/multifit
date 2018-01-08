function dict = dictconstruct(d, varargin)

    % DICTCONSTRUCT constructs a structure (dictionary) with variable name
    % and value pairs. If provided a non-empty dictionary, the function
    % appends entries it.
    % dict = dictconstruct(d, varargin)
    %
    % Parameters:
    % d -- input dictionary (Matlab structure)
    % varargin -- name-value pair entries in the format {name1, value1},
    % {name2, value2}, ... name need to be a string, while value can be a
    % scalar or matrix
    % 
    % Return:
    % Updated dictionary with new name-value pair entries
    
    dict = d; % Output initialized to user-provided dictionary d
    n_entry = numel(varargin);
    
    % Add name-value pairs to the dictionary
    if n_entry > 0
        for i = 1:n_entry
            
            varname = varargin{i}{1};
            varval = varargin{i}{2};
            % Add entries into structure
            evalc(['dict.', varname,' = varval']);
            
        end
    end

end