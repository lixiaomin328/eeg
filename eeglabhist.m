% EEGLAB history file generated on the 23-Sep-2019
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
[STUDY ALLEEG] = std_editset( STUDY, [], 'name','trigger2_1016','task','poker','commands',{ {'index' 1 'load' '/Volumes/colin/conditionsEEG/10b_condition1_triggerId2.set'} {'index' 2 'load' '/Volumes/colin/conditionsEEG/10b_condition2_triggerId2.set'} {'index' 3 'load' '/Volumes/colin/conditionsEEG/11b_condition1_triggerId2.set' 'load' '/Volumes/colin/conditionsEEG/11b_condition2_triggerId2.set'} {'index' 4 'load' '/Volumes/colin/conditionsEEG/11b_condition1_triggerId2.set'} {'index' 5 'load' '/Volumes/colin/conditionsEEG/12b_condition1_triggerId2.set'} {'index' 6 'load' '/Volumes/colin/conditionsEEG/12b_condition2_triggerId2.set'} {'index' 7 'load' '/Volumes/colin/conditionsEEG/13b_condition1_triggerId2.set'} {'index' 8 'load' '/Volumes/colin/conditionsEEG/13b_condition2_triggerId2.set'} {'index' 9 'load' '/Volumes/colin/conditionsEEG/14b_condition1_triggerId2.set'} {'index' 10 'load' '/Volumes/colin/conditionsEEG/14b_condition2_triggerId2.set'} {'index' 11 'load' '/Volumes/colin/conditionsEEG/15b_condition2_triggerId2.set'} {'index' 12 'load' '/Volumes/colin/conditionsEEG/15b_condition2_triggerId2.set' 'load' '/Volumes/colin/conditionsEEG/15b_condition1_triggerId2.set'} {'index' 13 'load' '/Volumes/colin/conditionsEEG/16b_condition1_triggerId2.set'} {'index' 14 'load' '/Volumes/colin/conditionsEEG/16b_condition2_triggerId2.set'}},'updatedat','on','savedat','on','rmclust','on' );
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
CURRENTSTUDY = 1; 
EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
EEG = eeg_checkset( EEG );
[STUDY EEG] = pop_savestudy( STUDY, EEG, 'filename','trigger2_study.study','filepath','/Volumes/colin/');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

STUDY = pop_statparams(STUDY, 'effect','marginal','groupstats','on','condstats','on','singletrials','on');
eeglab redraw;
