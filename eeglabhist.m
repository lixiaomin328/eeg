% EEGLAB history file generated on the 08-Aug-2019
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','11p1filter.set','filepath','/Users/lixiaomin/Documents/eeglab/');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'delete',1,'delete',1,'delete',1,'delete',1);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;
