function b = my_fir2(f_rotate, SampRate, order, filter_order)

%	my_fir2 - return the impulse response of a filter that approximates the
%		equalisation filter needed to make the LTASS spectrum of rotated speech
%		equal to its unrotated shape. if order='pre', it means the equalisation is
%		the one necessary when the shaping is performed before the modulation. If
%		order='post', then the equalisation is appropriate *after* the modulation.

%   Version 2.0 -- require explicit specification of filter order
% order 512 

MIN_FREQ = 0;
MAX_FREQ = 2 * f_rotate;
STEPS = 40;	
% FILTER_ORDER = 256;
% freqs = [0 50 ];
INCS = (MAX_FREQ-MIN_FREQ)/STEPS;
% minimum increment (in %) between adjacent defined bands
% MIN_INC = 1 ;

% generate a vector of frequencies 
freqs = linspace(MIN_FREQ, MAX_FREQ, STEPS);

% make the frequency vector extend out to the Nyquist frequency
freqs = [freqs, SampRate/2];

% generate the values of the desired function
% these are in dB

if strcmp(order, 'pre')
	m = (rot_ltss(freqs,f_rotate)-std_ltss(freqs));
else
	m = (std_ltss(freqs)-rot_ltss(freqs,f_rotate));
end

% plot(freqs,m);

% and so must be converted into linear ratios
m = 10.^(m/20);	

% plot(freqs,m);

norm_freqs = freqs*2/SampRate;

% plot(norm_freqs, m);

b=fir2(filter_order,norm_freqs,m);
[H,w]=freqz(b);
% plot(norm_freqs,20*log10(m),'r-',w/pi, 20*log10(abs(H)),'b-'), grid
plot(freqs,20*log10(m),'r-',(SampRate/2)*w/pi, 20*log10(abs(H)),'b-'), grid
% plot(b)

