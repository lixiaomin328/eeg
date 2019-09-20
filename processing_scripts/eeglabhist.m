% EEGLAB history file generated on the 18-Sep-2019
% ------------------------------------------------

EEG.etc.eeglabvers = 'development head'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_biosig('/Volumes/My Passport/12_EEG', 'channels',[1:64] );
EEG.setname='12aBDF file';
EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename','12a.set','filepath','/Volumes/colin/EEG_data/');
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'delete',1);
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename','12a.set','filepath','/Volumes/colin/outputTrigger1/12a/');
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 1, [-200  798], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'Fp1', 'baseline',[0], 'alpha',0.05, 'plotphase', 'off', 'padratio', 1, 'winsize', 100);
