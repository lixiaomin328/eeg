function [nFromEEGfile,nFromBehaviorData] = whetherMissingTrigger(subId)
if subId<15
load('startingTriggerTrial');
startingTrial = startingTrigerTrial(2,subId-9)+1;
else 
startingTrial =1;
end
LoadingDir = '/Volumes/colin/cutEEGdata/';
load('startingTriggerTrial');
filename = [num2str(subId),'b.set'];
>>>>>>> Stashed changes
run '../eeglab.m'
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);

%nFromEEGfile = sum([EEG.event.type]==65529|[EEG.event.type]==65530|[EEG.event.type]==65532|[EEG.event.type]==1|[EEG.event.type]==2|[EEG.event.type]==4);
[~,~,recoveredTrigger] = triggerFindP2(subId,startingTrial);
nFromBehaviorData = length(recoveredTrigger);
nFromEEGfile = length([EEG.event.type]);