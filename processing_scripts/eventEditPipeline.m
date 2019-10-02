inputFolder = '/Volumes/colin/eegResampled/';
outputFolder = '/Volumes/colin/eegResampled';
datafile = dir([inputFolder,'*.set']);
for i = length(datafile)-1:length(datafile)
filename = datafile(i).name;
subId = str2num(filename(1:2));
triggerEdit(subId,filename);
%EEG = pop_loadset('filename',filename,'filepath',inputFolder);
end