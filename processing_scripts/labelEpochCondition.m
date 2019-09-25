function [epochCondition1,epochCondition2,filename]=labelEpochCondition(triggerId,subId,playerRole)
playerRoleWords = {'b','a'};
filename = [num2str(subId),playerRoleWords{playerRole},'.set'];
LoadingDir = ['/Volumes/colin/outputTrigger',num2str(triggerId),'/',num2str(subId),playerRoleWords{playerRole},'/'];
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
eventTrialnum = [EEG.event.trialNum]';
eventEpoch  = [EEG.event.epoch]';
%%behavioral data search
behaviorDataPath = '../../poker/data_processing_scripts/DataMat/';
load([behaviorDataPath,'participant_',num2str(subId),'.mat']);
behavioralData = dataStructure;
allCards = [behavioralData.P1card,behavioralData.P2card];
cardIndex = allCards(:,playerRole);

%% Epoch num
epochTrialNum = zeros(EEG.trials,1);
for timeBin = 1:length(eventEpoch)
    epochTrialNum(eventEpoch(timeBin)) = eventTrialnum(timeBin);
end
epochCards = cardIndex(epochTrialNum);%what card is shown on each time point
epochCondition1 = find(epochCards>3&epochCards<7);
epochCondition2 = find(epochCards>6|epochCards<4);

%data1 = EEG.data(53,:,epochCondition1);
%data2 = EEG.data(53,:,epochCondition2);