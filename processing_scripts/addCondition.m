triggerId = 7;
allConditions = {'bluffOrNot','highLowCards','randControl','betOrNot'};
conditionNum = 4;
condition = allConditions{conditionNum};
LoadingDir=['/Volumes/colin/outputTrigger',num2str(triggerId),'/'];
eegFiles = dir([LoadingDir,'*.set']);

for subId = 1:length(eegFiles)
    filename = eegFiles(subId).name;
    EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
    EEG.subject =filename(1:3);
    [epochCondition1,epochCondition2]=labelEpochCondition(LoadingDir,filename,condition);
    conditionLables = zeros(EEG.trials,1)-1;
    conditionLables(epochCondition1)= 1;
    conditionLables(epochCondition2)= 0;
    for j = 1:length(EEG.event)
        if conditionNum==4
        EEG.event(j).betOrNot = conditionLables(EEG.event(j).epoch);
        end
    end
    EEG = pop_saveset(EEG,'filename',filename,'filepath',LoadingDir);
end