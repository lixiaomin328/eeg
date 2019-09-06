function [nFromEEGfile,nFromBehaviorData] = whetherMissingTrigger(subId)
LoadingDir = '/Volumes/colin/EEG_data/';
load('startingTriggerTrial');
startingTrial = startingTrigerTrial(2,subId-9)+1;
filename = [num2str(subId),'a.set'];
run '../eeglab.m'
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);

%nFromEEGfile = sum([EEG.event.type]==65529|[EEG.event.type]==65530|[EEG.event.type]==65532|[EEG.event.type]==1|[EEG.event.type]==2|[EEG.event.type]==4);
[p2DecisionStart,p2DecisionMade,recoveredTrigger] = triggerFindP2(subId,startingTrial);
nFromBehaviorData = length(recoveredTrigger);
nFromEEGfile = length([EEG.event.type]);