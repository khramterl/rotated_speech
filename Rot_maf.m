function dB = rot_maf(f, f_rotate)

%	rot_maf - returns the shape of the MAF (minimum audible field)
%		rotated around a given frequency.
%
%	if f>2*f_rotate, which implies values at negative frequencies of std_ltss,
%	this returns the value at 1 Hz to maintain continuity. This feature is
%	implemented in maf()

%
%	dB = rot_maf(f, rotating_frequency)

	dB = maf(2*f_rotate-f);