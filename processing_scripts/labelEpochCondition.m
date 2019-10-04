function [epochCondition1,epochCondition2,filename]=labelEpochCondition(triggerId,subId,playerRole,condition)
%condition, 'bluffOrNot','highLowCards','randControl','betOrNot'
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
allBehaviorals = [behavioralData.player1ActionCheck_keys,behavioralData.player2ActionCheck_keys];
behavIndex = allBehaviorals(:,playerRole);
%% Epoch num
epochTrialNum = zeros(EEG.trials,1);
for timeBin = 1:length(eventEpoch)
    epochTrialNum(eventEpoch(timeBin)) = eventTrialnum(timeBin);
end
epochCards = cardIndex(epochTrialNum);
epochBev = behavIndex(epochTrialNum);%what card is shown on each time point
%'bluffOrNot','highLowCards','randControl','betOrNot'
if strcmp(condition,'bluffOrNot')
    epochCondition1 = find(epochCards==2|epochCards==3&epochBev==1);
    epochCondition2 = find(epochCards==2|epochCards==3&epochBev==0);
    fprintf('condition 1 is bluff and 2 is not bluff')
elseif strcmp(condition,'highLowCards')
epochCondition1 = find(epochCards>3&epochCards<7);
epochCondition2 = find(epochCards>6|epochCards<4);
fprintf('condition 1 is middle card and 2 is boundary card')
elseif strcmp(condition,'randControl')
randNum = randi(2,length(epochCards),1);
epochCondition1 = find(randNum==2);
epochCondition2 = find(randNum==1);
elseif strcmp(condition,'betOrNot')
    epochCondition1 = find(epochBev==1);
epochCondition2 = find(epochBev==0);
fprintf('condition 1 is bet and 2 is pass')
end
    

%data1 = EEG.data(53,:,epochCondition1);
%data2 = EEG.data(53,:,epochCondition2);