% EEGLAB history file generated on the 25-Aug-2019
% ------------------------------------------------

EEG.etc.eeglabvers = 'development head'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_biosig('/Users/xiaominli/Google Drive/EEG POKEr/10.bdf');
EEG.setname='10BDF file';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'append',{26 [] [] []},'changefield',{27 'latency' 78.266},'changefield',{27 'type' 65529});
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'append',{201 [] [] []},'changefield',{202 'latency' 628.9111},'changefield',{202 'type' 65530});
EEG = pop_editeventvals(EEG,'append',{216 [] [] []},'changefield',{217 'latency' 680.7900},'changefield',{217 'type' 65530});
