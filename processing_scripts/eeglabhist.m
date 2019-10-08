% EEGLAB history file generated on the 07-Oct-2019
% ------------------------------------------------

LoadingDir = '/Volumes/colin/EEG_data/';
filename = [num2str(subId),'a.set'];
run '../eeglab.m'
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'delete',1,'delete',1,'delete',1,'delete',1);
EEG = eeg_checkset( EEG );
EEG = pop_saveset(EEG,'filename',filename,'filepath',LoadingDir);

