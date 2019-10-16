function conditionEEG(triggerId,subId,playerRole,condition)
outputDir = '/Volumes/colin/conditionsEEG';
if ~exist(outputDir)
    mkdir(outputDir)
end
conditionNum=2;
playerRoleWords = {'b','a'};
LoadingDir=['/Volumes/colin/outputTrigger',num2str(triggerId),'/'];
filename = [num2str(subId),playerRoleWords{playerRole},'.set'];
%eegFiles = dir([LoadingDir,'*.set']);
%subLoadingDir = [LoadingDir,num2str(subId),playerRoleWords{playerRole},'/'];
[epochCondition1,epochCondition2]=labelEpochCondition(LoadingDir,filename,condition);
if ~exist([LoadingDir,filename])
    return
end
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
%if ~exist('condition')
conditions_EEG = [EEG;EEG];
conditionEpochSequence = {epochCondition1,epochCondition2};
for condition = 1:conditionNum
saveFileName = [num2str(subId),playerRoleWords{playerRole},'_condition',num2str(condition),'_triggerId','.set'];
condition_EEG = conditions_EEG(condition);
condition_EEG.data = condition_EEG.data(:,:,conditionEpochSequence{condition});
%condition_EEG.icaact = condition_EEG.icaact(:,:,conditionEpochSequence{condition});
condition_EEG.epoch = condition_EEG.epoch(conditionEpochSequence{condition});
condition_EEG.subject = num2str(subId);
condition_EEG.condition = num2str(condition);
condition_EEG.trials = length(conditionEpochSequence{condition});
pop_saveset(condition_EEG, 'filename',saveFileName,'filepath',outputDir);
end