%event relabel file
%load behavior data
%subId=15;
function [p2DecisionStart,p2DecisionMade,recoveredTrigger,recoveredTrialNum] = triggerFindP2(subId,startingTrial)
behaviorDataPath = '../../poker/data_processing_scripts/DataMat/';
load([behaviorDataPath,'participant_',num2str(subId),'.mat']);
behavioralData = dataStructure;
trialIndex = (3*(behavioralData.player2ActionCheck_keys))+behavioralData.player1ActionCheck_keys;
recoveredTrigger = [];
trialStart = [];
recoveredTrialNum = [];
for trial =startingTrial:length(behavioralData.player1ActionCheck_keys)
     if trialIndex(trial)==-3%%p1check
         recoveredTrigger = [recoveredTrigger;1;2;4];
         trialStart = [trialStart;length(recoveredTrigger)-2];
         recoveredTrialNum = [recoveredTrialNum;trial;trial;trial];
     elseif trialIndex(trial)==4%%betbet
         recoveredTrigger = [recoveredTrigger;1;2;1;2;4];
         trialStart = [trialStart;length(recoveredTrigger)-4];
         recoveredTrialNum = [recoveredTrialNum;trial;trial;trial;trial;trial];
     
     elseif trialIndex(trial)==1%%betfold
          recoveredTrigger = [recoveredTrigger;1;2;1;2;4];
         trialStart = [trialStart;length(recoveredTrigger)-4];
         recoveredTrialNum = [recoveredTrialNum;trial;trial;trial;trial;trial];
     
     elseif trialIndex(trial)==-4%%p1timeout
         recoveredTrigger = [recoveredTrigger;1];
         trialStart = [trialStart;length(recoveredTrigger)];
         recoveredTrialNum = [recoveredTrialNum;trial];   
     elseif trialIndex(trial)==-2%%p2timeout
         recoveredTrigger = [recoveredTrigger;1;2;1];
         trialStart = [trialStart;length(recoveredTrigger)-2];
         recoveredTrialNum = [recoveredTrialNum;trial;trial;trial];
     end
end
trialIndex = trialIndex(startingTrial:end);
p2HasActionTrialStart =[trialStart(find(trialIndex==4));trialStart(find(trialIndex==1))];
p2HasActionTrialStart = sort(p2HasActionTrialStart);
p2DecisionStart = p2HasActionTrialStart+2;
p2DecisionMade = p2HasActionTrialStart+3;