% EEGLAB history file generated on the 23-Sep-2019
% ------------------------------------------------
allConditions = {'bluffOrNot','highLowCards','randControl','betOrNot'};
conditionNum = 4;
minIca = 59;
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
loadingFolder = '/Volumes/colin/outputTrigger7/';
conditionEEGfiles = dir([loadingFolder,'*b.set']);
listAll = cell(1,2*length(conditionEEGfiles)+1);
%studyLists = cell(1,length(conditionEEGfiles));
%icaLists = cell(1,length(conditionEEGfiles));
for subId = 1:length(conditionEEGfiles)
    oneEntry = {'index' subId 'load' [loadingFolder,conditionEEGfiles(subId).name]};
    icaEntry = {'index' subId 'comps' [1:minIca] };
    listAll{subId}=oneEntry; 
    
    listAll{length(conditionEEGfiles)+1+subId} = icaEntry;
end
listAll{length(conditionEEGfiles)+1} ={'inbrain' 'on' 'dipselect' 0.15};
[STUDY ALLEEG] = std_editset( STUDY, [], 'name',['trigger1_1018',allConditions{conditionNum}],'task','poker',...
'commands',listAll,...
    'updatedat','on','savedat','on','rmclust','on');
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
CURRENTSTUDY = 1; 
EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
EEG = eeg_checkset( EEG );
[STUDY EEG] = pop_savestudy( STUDY, EEG, 'filename','trigger1_study.study','filepath',loadingFolder);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

STUDY = pop_statparams(STUDY, 'effect','marginal','groupstats','on','condstats','on','singletrials','on');
eeglab redraw;

