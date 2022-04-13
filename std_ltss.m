function dB = std_ltss(f)

%	std_ltss - returns the shape of the long-term average spectrum of speech
%		as given by Byrne, D. et al. (1994) "An international comparison 
%		of long-term average speech spectra, J. Acoust. Soc. Am. 96, 2108-2120. 
%
%	Here, though, we ignore the fact that the LTASS rolls off below 120 Hz at a slope
%	of -17.5 dB/octave, and assume it is flat from 420 Hz down.
%
%	dB = std_ltss(f)
% Version 2 -- June 2001
%   correct bug in protecting against negative frequencies


	% protect against zero and negative frequencies by setting the value to 1 Hz
	f = (f.*(f>0))+(f<=0);
	dB = (f>420) .* (-7.2 * log10(f/420)/log10(2)); 

% NOTE: This can also be written using log2()