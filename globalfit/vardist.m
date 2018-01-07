function varargout = vardist(vararray, veclen, nvectorvar, nscalarvar)
    
    % VARDIST reshapes a 2D array and distribute the values to a list of
    % variables of either vectorial or scalar types.
    % varargout = VARDIST(vararray, veclen, nvectorvar, nscalarvar)
    %
    % Parameters:
    % vararray -- 2D array of variable values
    % veclen -- length of vectorial variables (all vectorial variables need
    % to have the same length)
    % nvectorvar -- number of vectorial variables
    % nscalarvar -- number of scalar varibales
    %
    % Returns:
    % The function outputs a total of nvectorvar + nscalarvar numbers of
    % parameters depending on the specified numbers
    
    % Reshape array into row form
    [nr, nc] = size(vararray);
    if nr < nc
        vararray = vararray';
        [nr, nc] = size(vararray);
    end
    
    varargout = {};
    nvals = nr;
    idx = [1:floor(nvals/veclen)]*veclen;
    idx = [1 idx];
    
    % Check if the number of entries are sufficient
    % Throw and error if the number of entries is less than those to be distributed
    % Throw a warning if the number of entries is more than those to be distributed
    if nvals < idx(end) + nscalarvar
        error('Input array has not enough entries to distribute into specified lengths.');
    elseif nvals > idx(end) + nscalarvar
        warning('There are more values in the input array than will be distributed!');
    end
    
    % Pick out vectorial variables
    for v = 1:nvectorvar
       varargout{v} = vararray(idx(v):idx(v+1),:);
    end
        
    % Pick out scalar variables
    for s = 1:nscalarvar
        varargout{nvectorvar+s} = vararray(idx(end)+s,:);
    end

end