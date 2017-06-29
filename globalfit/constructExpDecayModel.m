function fComplexDecayModel = constructExpDecayModel(n)
    % The function multisine_fitfunc() generates fitting functions in the
    % form of the sum of a series of exponential decays, the
    % results is returned as a string to be used as the input for the
    % iterative fitting routine or using any of Matlab's fitting functions
    %
    % The variables are named as
    % a -- amplitude
    % s -- exponential decay time constant
    %
    % The input n needs to be a positive integer (n = 1,2,3...).
    
    n = floor(n);

    % Generate subscript sequence (a separate string of numbers)
    ord = arrayfun(@(x) sprintf('%d',x), 1:n, 'UniformOutput', false);
    
    % list of variable name roots
    varname = cellstr({'a', 's'});
    
    % Generate all variables in 1D cell array
    [ind1, ind2] = ndgrid(cellseq(varname), cellseq(ord));
    vararray = arrayfun(@(v1,v2) [varname{v1},ord{v2}], ind1(:),ind2(:), 'UniformOutput', false);
    
    % Split the variables into subclasses of variables
    nvararray = reshape(vararray, [2,n]);
    avar = nvararray(1,:);
    svar = nvararray(2,:);
    
    % Construct function form based on input size n (# of exponential decay terms)
    fform = [];
    
    for i = 1:n
        % Combine every exponential decay function to form the output function
        fform = [fform,avar{i},'*exp(-t/',svar{i},')','+'];        
    end
    
    % Remove the extra '+' sign at the end
    fform = fform(1:end-1);
    
    % Turns cell array into a comma-separated string
    varstr = strjoin(vararray,',');
    
    % Convert string expression into anonymous function
    fExponentialDecay = str2func( ['@(', varstr, ', t) ', fform] );
    
    % Convolute with a Gaussian system response function
    fGaussianResponse = @(t, t0, sg) (1/(sg*sqrt(2*pi)))*exp(-((t-t0).^2)/(2*sg.^2));
    fComplexDecayModel = str2func( ['int(fExponentialDecay(', varstr, 'u)*fGaussianResponse(t-u, t0, sg),"u",-inf,+inf)'] );
    
    
    function seqarray = cellseq(cellarray)
        % Construct a sequence from 1 to the length of the array with step 1
        
        clength = length(cellarray);
        seqarray = 1:clength;
        
    end
    
end
