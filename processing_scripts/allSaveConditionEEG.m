triggerId = 1;
allConditions = {'bluffOrNot','highLowCards','randControl','betOrNot'};
conditionNum = 4;
condition = allConditions{conditionNum};
for subId = 10:17 
for playerRole = 1
    conditionEEG(triggerId,subId,playerRole,condition)
end
end