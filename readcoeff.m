function vals = readcoeff(fitvalues, varname)
    % Read coefficients from the results obtained from multisinefit()
    
    % Construct name-value pair
    namepair = struct('a', 1, 'b', 2, 'c', 3, 'ph', 4);
    
    if ~ischar(varname)
        error('Please specify the fitting parameter name in a string.')
        
    elseif ~isfield(namepair, varname)
        error('No variable of such name is found.')
        
    else
        % Reshape fitting values matrix to bring all values of the same
        % type (e.g. a1, a2, a3, ...) in one row
        fitvalmat = reshape(fitvalues, [numel(fitvalues)/4 4]);
    
        % Extract the fitting values based on the row they reside (this
        % avoids using big if or switch clause)
        vals = fitvalmat(:, getfield(namepair, varname));
    
end