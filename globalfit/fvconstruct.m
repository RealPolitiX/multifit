function vect = fvconstruct(vectorvar, vectlen, varargin)

    % FVCONSTRUCT constructs the flattened fitting vector (fv) including
    % both vectorial and scalar variables
    % vect = FVCONSTRUCT(vectorvar, vectlen, varargin)
    % 
    % Parameters:
    % vectorvar -- values of the vectorial variables
    % vectlen -- length of the vectorial variables to be replicated
    %
    % Keyword parameters: 
    % ScalarVar -- scalar variables
    %
    % Return:
    % vect -- 1D array of fitting vector, vectorial followed by scalar
    
    % Parse input argument
    psr = inputParser;
    addParameter(psr, 'ScalarVar', []);
    parse(psr, varargin{:});
    scalarvar = psr.Results.ScalarVar;
    
    nscal = numel(scalarvar);
    vect = []; % Minimal output is empty array
    
    % Replicate vectorial variables and append to output array
    vectmat = repmat(vectorvar, vectlen, 1);
    vect = reshape(vectmat, 1, numel(vectmat));
    
    % Append to output array
    if ~isempty(scalarvar)
        vect(end+1:end+nscal) = scalarvar;
    end

end