% EEGLAB history file generated on the 09-Oct-2019
% ------------------------------------------------

EEG.etc.eeglabvers = 'development head'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_biosig('/Volumes/colin/eeg_poker/18_EEG');
EEG.setname='18BDF file';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'channel',{'1-A1' '1-A2' '1-A3' '1-A4' '1-A5' '1-A6' '1-A7' '1-A8' '1-A9' '1-A10' '1-A11' '1-A12' '1-A13' '1-A14' '1-A15' '1-A16' '1-A17' '1-A18' '1-A19' '1-A20' '1-A21' '1-A22' '1-A23' '1-A24' '1-A25' '1-A26' '1-A27' '1-A28' '1-A29' '1-A30' '1-A31' '1-A32' '1-B1' '1-B2' '1-B3' '1-B4' '1-B5' '1-B6' '1-B7' '1-B8' '1-B9' '1-B10' '1-B11' '1-B12' '1-B13' '1-B14' '1-B15' '1-B16' '1-B17' '1-B18' '1-B19' '1-B20' '1-B21' '1-B22' '1-B23' '1-B24' '1-B25' '1-B26' '1-B27' '1-B28' '1-B29' '1-B30' '1-B31' '1-B32' '1-EXG1' '1-EXG2' '1-EXG3' '1-EXG4' '1-EXG5' '1-EXG6'});
EEG.setname='18aBDF file';
EEG = pop_loadset('filename','18a.set','filepath','/Volumes/colin/EEG_data/');
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'delete',1,'delete',1,'delete',1,'delete',1);
EEG = eeg_checkset( EEG );
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:63] ,'computepower',1,'linefreqs',[60 120] ,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',1,'sigtype','Channels','tau',100,'verb',1,'winsize',4,'winstep',1);
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 256);
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
EEG = eeg_checkset( EEG );
