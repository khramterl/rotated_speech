function [OutWave1, OutWave2] = no_clip2(InWave1, InWave2)

%	NO_CLIP - correct for any possible sample overloads

max_sample = max(abs([InWave1' InWave2']));
if max_sample > 0.999	% ---- !! OVERLOAD !! -----
	% figure out degree of attenuation necessary
	ratio = 0.999/max_sample;
   OutWave1 = InWave1 * ratio;
  	OutWave2 = InWave2 * ratio;
	fprintf('!! WARNING -- OVERLOAD !! Both files scaled by %f = %f dB\n', ratio, 20*log10(ratio));
else 
   OutWave1 = InWave1;
  	OutWave2 = InWave2;
end
