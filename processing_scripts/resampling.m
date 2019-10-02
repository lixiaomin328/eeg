inputFolder = '/Volumes/colin/outputTrigger1/17b';
datafile = dir('/Volumes/colin/outputTrigger1/17b/*.set');
SavingDir = '/Volumes/colin/outputTrigger1/17b';
for i = 1%length(datafile)-1:length(datafile)
filename = datafile(i).name;
subId = str2num(filename(1:2));
EEG = pop_loadset('filename',filename,'filepath',inputFolder);
EEG = pop_resample(EEG,512);
EEG = pop_saveset(EEG, 'filename',filename,'filepath',SavingDir);
%EEG = pop_loadset('filename',filename,'filepath',inputFolder);
end