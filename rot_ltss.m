function dB = rot_ltss(f, f_rotate)

%	rot_ltss - returns the shape of the long-term average spectrum of speech
%		as given by Byrne, D. et al. (1994) "An international comparison 
%		of long-term average speech spectra, J. Acoust. Soc. Am. 96, 2108-2120,
%		but rotated around a given frequency.
%
%	if f>2*f_rotate, which implies values at negative frequencies of std_ltss,
%	this returns the value at 1 Hz to maintain continuity. This feature is
%	implemented in std_ltss()

%
%	dB = rot_ltss(f, rotating_frequency)

	dB = std_ltss(2*f_rotate-f);