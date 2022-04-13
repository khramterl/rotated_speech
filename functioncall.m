% blesser3(4000,'C:\Users\Priscila\OneDrive\Documentos\Wien\Methods\Pilot_task\blesser-rotated-speech\original\wav-original\pronunciation_de_bar.wav', 'pronunciation_de_bar_lo.wav', 'pronunciation_de_bar_rot.wav');
clear all;
Folder = cd;
parentFolder = fullfile(Folder, '..');
[parentFolderPath,~,~] = fileparts(parentFolder);
inputDir = parentFolderPath + "\stimuli\sound";
outputDir = parentFolderPath + "\stimuli\sound\rotated";
postfix = "_lpf";
process_lots(inputDir, outputDir, postfix);