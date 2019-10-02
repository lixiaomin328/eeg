%eventEdit load EEGdata first
function triggerEdit(subId,filename)
%%for some data the it is not starting from trial 1
if subId<15
load('startingTriggerTrial');
startingTrial = startingTrigerTrial(2,subId-9)+1;
else 
startingTrial =1;
end
%%
%inputFolder = '/Volumes/colin/EEG_data/';
%outputFolder = '/Volumes/colin/cutEEGdata';
inputFolder = '/Volumes/colin/eegResampled/';
outputFolder = '/Volumes/colin/eegResampled';
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