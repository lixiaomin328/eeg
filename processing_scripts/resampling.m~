inputFolder = '/Volumes/colin/EEG_data/';
datafile = dir([inputFolder,'*.set']);
SavingDir = '/Volumes/colin/eegResampled/';
for i = length(datafile)-1:length(datafile)
filename = datafile(i).name;
subId = str2num(filename(1:2));
EEG = pop_loadset('filename',filename,'filepath',inputFolder);
EEG = pop_resample(EEG,512);
EEG = pop_saveset(EEG, 'filename',filename,'filepath',SavingDir);
%EEG = pop_loadset('filename',filename,'filepath',inputFolder);
end