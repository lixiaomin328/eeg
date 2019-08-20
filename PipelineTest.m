% EEGLAB history file generated on the 08-Aug-2019
% ------------------------------------------------
pathElp = '/Users/xiaominli/Downloads/Biosemi64.elp';
datafile= '../eeg/11_EEG.bdf';
SavingDir = '/Users/xiaominli/Documents/eeg/';
LoadingDir = '/Users/xiaominli/Documents/eeg/';
filename = '11a.set';
saveFilename = ['processed',filename];
lowBound=1;
highBound = 60;
 % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
eeglab redraw;
EEG.setname='PipelineFile';
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'load',{pathElp 'filetype' 'autodetect'});
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 800);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 'locutoff',lowBound);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 'hicutoff',highBound);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',saveFilename,'filepath',SavingDir);
%%event editing
% event = EEG.event;
% indexEnd = find([event(1:end).type]==65532);%finding reveal part
% indexTrialStart = indexEnd+1;
% indexTrialStart = indexTrialStart(1:end-1);
% event(1).type = 1;
% event(indexTrialStart).type = 1;
