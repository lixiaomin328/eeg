% EEGLAB history file generated on the 01-Oct-2019
% ------------------------------------------------
loadingDir = ['/Volumes/colin/outputTrigger',num2str(triggerId)];
playerRoleWords = {'b','a'};
%EEGfiles = dir(LoadingDir);
for playerRole = 1:2
    for subId = 16:17
        subLoadingDir = [loadingDir,'/',num2str(subId),playerRoleWords{playerRole},'/'];
        
        filename = [num2str(subId),playerRoleWords{playerRole},'.set'];
        EEG = pop_loadset('filename',filename,'filepath',subLoadingDir);
        EEG = pop_select( EEG, 'channel',{'Fp1' 'AF7' 'AF3' 'F1' 'F3' 'F5' 'F7' ...
            'FT7' 'FC5' 'FC3' 'FC1' 'C1' 'C3' 'C5' 'T7' 'TP7' 'CP5' 'CP3' 'CP1' 'P1' ...
            'P3' 'P5' 'P7' 'P9' 'PO7' 'PO3' 'O1' 'Iz' 'Oz' 'POz' 'Pz' 'CPz' 'Fpz' 'Fp2' ...
            'AF8' 'AF4' 'Afz' 'Fz' 'F2' 'F4' 'F6' 'F8' 'FT8' 'FC6' 'FC4' 'FC2' 'FCz' 'Cz' ...
            'C2' 'C4' 'C6' 'T8' 'TP8' 'CP6' 'CP4' 'CP2' 'P2' 'P4' 'P6' 'P8' 'P10' 'PO8' 'PO4' 'O2'});
        pop_saveset(EEG, 'filename',filename,'filepath',subLoadingDir);
    end
end
