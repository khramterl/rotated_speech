function process_lots(InputDir, OutputDir, postfix)

%	Run blesser3 for an entire set of files in a particular directory
%
%  function process_lots(InputDir, OutputDir, postfix)
%     postifix is a string (typically a character) to indicate condition
%
%	Stuart Rosen November 2001 -- modified to get .wav files in a smarter way
%	stuart@phon.ucl.ac.uk

Files = dir(fullfile(InputDir, '*.wav'));
nFiles = size(Files);

% Does the output directory exist? If not, make it.
status = mkdir(OutputDir);
if status==0 
   fprintf('ERROR: Cannot create new output directory %s.\n', OutputDir);
   return;
end

for i=1:nFiles
    InputFile = fullfile(InputDir, Files(i).name);
    [path, root, ext] = fileparts(Files(i).name);
    OutputFileLo = OutputDir + '\' + root + postfix + '.wav';
    OutputFileRot = OutputDir + '\' + root + postfix + '_rotated.wav';
    feval('blesser3', 4000, InputFile, OutputFileLo, OutputFileRot);
end