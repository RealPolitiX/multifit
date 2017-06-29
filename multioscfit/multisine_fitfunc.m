function fform = multisine_fitfunc(n, stype)
    % The function multisine_fitfunc() generates fitting functions in the
    % form of the sum of a series of sinusoidal exponential decays, the
    % results is returned as a string to be used as the input for the
    % iterative fitting routine or using any of Matlab's fitting functions
    %
    % The variables are named as
    % a -- amplitude
    % b -- decay time constant
    % c -- frequency of the sinusoid
    % ph -- initial phase of the sinusoid
    %
    % The input n needs to be a positive integer (n = 1,2,3...).
    % The stype specifies the type of the oscillatory function ('sin' or 'cos')
    
    if ~exist('stype','var')
        stype = 'sin';
    end
    
    n = floor(n);

    % generate subscript sequence (a separate string of numbers)
    subseq = arrayfun(@(x) sprintf('%d',x),1:n,'uni',false);
    
    % list of variable name roots
    vname = cellstr({'a', 'b', 'c', 'ph'});
    
    % construct function form based on input size n (# of terms)
    fform = [];
    
    for i = 1:n        
        % generate variable names for each sinusoidal decay function
        avar = [vname{1}, subseq{i}];
        bvar = [vname{2}, subseq{i}];
        cvar = [vname{3}, subseq{i}];
        phvar = [vname{4}, subseq{i}];
        
        % combine every sinusoidal decay function to form the output function
        switch stype
            case 'sin'
                fform = [fform,avar,'*exp(-x/',bvar,')*sin(2*pi*',cvar,'*x+',phvar,')+'];
            case 'cos'
                fform = [fform,avar,'*exp(-x/',bvar,')*cos(2*pi*',cvar,'*x+',phvar,')+'];
        end
        
    end
    
    % remove the extra '+' sign at the end
    fform = fform(1:end-1);
    
end
