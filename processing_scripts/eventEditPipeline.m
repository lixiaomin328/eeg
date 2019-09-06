inputFolder = '/Volumes/colin/EEG_data/';
outputFolder = '/Volumes/colin/cutEEGdata';
datafile = dir('/Volumes/colin/EEG_data/*.set');
for i = 1:length(datafile)
filename = datafile(i).name;
subId = str2num(filename(1:2));
triggerEdit(subId,filename);
%EEG = pop_loadset('filename',filename,'filepath',inputFolder);
end