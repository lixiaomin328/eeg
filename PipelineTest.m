% EEGLAB history file generated on the 08-Aug-2019
% ------------------------------------------------
pathElp = '/Users/lixiaomin/Downloads/Biosemi64.elp';
datafile= '../eeg/11_EEG.bdf';
lowBound=1;
highBound = 60;
[ALLEEG,EEG,CURRENTSET,ALLCOM] = eeglab;
EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_biosig(datafile);
EEG.setname='PipelineFile';
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'2-A1' '2-A2' '2-A3' '2-A4' '2-A5' '2-A6' '2-A7' '2-A8' '2-A9' '2-A10' '2-A11' '2-A12' '2-A13' '2-A14' '2-A15' '2-A16' '2-A17' '2-A18' '2-A19' '2-A20' '2-A21' '2-A22' '2-A23' '2-A24' '2-A25' '2-A26' '2-A27' '2-A28' '2-A29' '2-A30' '2-A31' '2-A32' '2-B1' '2-B2' '2-B3' '2-B4' '2-B5' '2-B6' '2-B7' '2-B8' '2-B9' '2-B10' '2-B11' '2-B12' '2-B13' '2-B14' '2-B15' '2-B16' '2-B17' '2-B18' '2-B19' '2-B20' '2-B21' '2-B22' '2-B23' '2-B24' '2-B25' '2-B26' '2-B27' '2-B28' '2-B29' '2-B30' '2-B31' '2-B32'});
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'load',{pathElp 'filetype' 'autodetect'});
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 1024);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 'locutoff',lowBound);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 'hicutoff',highBound);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG = eeg_checkset( EEG );
%%event editing
EEG = pop_editeventvals(EEG,'delete',1,'delete',1,'delete',1,'delete',1);
[ALLEEG,EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
event = EEG.event;
indexEnd = find([event(1:end).type]==65532);%finding reveal part
indexTrialStart = indexEnd+1;
indexTrialStart = indexTrialStart(1:end-1);
event(1).type = 1;
event(indexTrialStart).type = 1;
