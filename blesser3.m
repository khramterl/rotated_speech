function blesser3(mf, InputFile, LowPassOp, RotatedOp)

%  BLESSER3 - This program reconstructs speech with an inverted spectrum
%	around a chosen centre frequency. 
%
%   Version 3.1 -- my_fir2 needs an explicit specification of filter order
%	Version 3.0 -- Lose special rms function through call to standard procedure
%						Lose decimation to a lower sampling frequency
%						Attenuate both rotated and low-pass filtered output waveforms if either is too big
% 	Version 2.0 -- clean up input/output to use new facilities
%		Pad out waveform by 100 ms to make sure no part of the speech is lost
%		through processing delay.
%
%   blesser3(mf, InputFile, LowPassOp, RotatedOp)
%		mf - maximum frequency in spectrum (Hz) - rotation frequency = mf/2
%		InputFile - Input filename in quotes, e.g., 'heed.wav'
%		LowPassOp - Lowpass outputFile name - in quotes, e.g., 'heed_lo.wav'
%		RotatedOp - Rotated outputFile name - in quotes, e.g., 'heed_r.wav'
%
%	For example:
%	blesser3(4000,'0101.wav', '0101_lo.wav', '0101_rot.wav')
%
%
% Stuart Rosen (2001)
% stuart@phon.ucl.ac.uk

if nargin<3
   fprintf('Type: help blesser3 for more help.\n\n');
   return;
end

fprintf('Processing %s\n', InputFile);

% read the waveform, also picking up the sampling frequency (SampFreq) --
[x, SampFreq] = audioread(InputFile);
% Extend the waveform by 100 ms to ensure end of speech is not lost through processing delays
x = [x' zeros(size(x,2),(100/1000)*SampFreq)]';

%----------------------------------------------------------------
% Lowpass filter the original signal so that there is effectively
% no energy at or above the rotation frequency
%----------------------------------------------------------------
% set lowpass filter cutoff to be a fraction of the maximum frequency in the spectrum
lpf = 0.95 * mf;
[blpf, alpf]=ellip(6,0.5,35,lpf/(SampFreq/2)); 
x=filtfilt(blpf,alpf,x);

n_samples=length(x);
input_rms = norm(x)/sqrt(length(x));

% generate a sine wave of frequency 'mf' to modulate original waveform
modulator=sin(2.0*pi*mf*linspace(1,n_samples,n_samples)/SampFreq)';

% PRE-MODULATION-EQUALISATION
% equalize the original waveform so as to have a similar 
% overall spectrum on output as on input
% first design an appropriate FIR Filter
b = my_fir2(mf/2, SampFreq, 'pre', 256);
% now filter the original
y = fftfilt(b, x);

wave=y.*modulator;
wave=filtfilt(blpf,alpf,wave);

% scale to equivalent rms of input
wave = wave * (input_rms/(norm(wave)/sqrt(length(wave))));

% --- check that no sample point leads to an overload
[wave, x] = no_clip2(wave, x);

% ------------ save both outputs to a file -----------
audiowrite(LowPassOp, x, SampFreq);
audiowrite(RotatedOp, wave, SampFreq);
