function trace = travg(tracemat, centerwv, bandwiz, wavelen)
    % travg(tracemat, centerwv, bandwiz, wavelen)
    % Calculate the averaged transient absorption trace from averaging the
    % data around a center wavelength with a specified bandwidth (centerwv,
    % bandwiz, wavelen all have units in nm)
    
    % bandwiz should be a positive number, usually 0-5
    hbandwiz = bandwiz/2;
    
    % Find the pixel number corresponding to the lower bound wavelength
    % (lbpxl = lower bound pixel number)
    lbpxl = wave2seq(centerwv - hbandwiz, wavelen);
    
    % Find the pixel number corresponding to the upper bound wavelength
    % (ubpxl = upper bound pixel number)
    ubpxl = wave2seq(centerwv + hbandwiz, wavelen);
    
    % Find the larger dimension of the two in the input data matrix
    % (tracemat), returning 1 (row) or 2 (column)
    largerdim = find(size(tracemat) == length(tracemat));
    
    % Average over the wavelength (usually the larger dimension of the
    % data matrix (tracemat)
    if largerdim == 1
        trace = mean(tracemat(lbpxl:ubpxl, :), largerdim);
    elseif largerdim == 2
        trace = mean(tracemat(:, lbpxl:ubpxl), largerdim);
    end
    
end
