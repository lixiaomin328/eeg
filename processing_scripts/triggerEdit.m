%eventEdit load EEGdata first
function triggerEdit(subId,filename)
load('startingTriggerTrial');
startingTrial = startingTrigerTrial(2,subId-9)+1;
inputFolder = '/Volumes/colin/EEG_data/';
outputFolder = '/Volumes/colin/cutEEGdata';
EEG = pop_loadset('filename',filename,'filepath',inputFolder);
[p2DecisionStart,p2DecisionMade,recoveredTrigger,recoveredTrialNum] = triggerFindP2(subId,startingTrial);
for i = 1:length(p2DecisionStart)
    recoveredTrigger(p2DecisionStart(i))=3;
    recoveredTrigger(p2DecisionMade(i))=5;
end

for j = 1:length(recoveredTrigger)
    EEG.event(j).type = recoveredTrigger(j);
    EEG.event(j).trialNum = recoveredTrialNum(j);
end
EEG = pop_saveset(EEG,'filename',filename,'filepath',outputFolder);