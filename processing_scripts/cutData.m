LoadingDir = '/Volumes/colin/eegResampledEOG/';
SavingDir = '/Volumes/colin/eegResampled/';
eegFiles = dir([LoadingDir,'*.set']);
for subId = 1:length(eegFiles)
filename = eegFiles(subId).name;
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
channels = struct2cell(EEG.chanlocs);
selectedChannels  = channels(1,1:64);
EEG = pop_select( EEG, 'channel',selectedChannels);
EEG = eeg_checkset(EEG);
EEG = pop_saveset( EEG, 'filename',filename,'filepath',SavingDir);
end