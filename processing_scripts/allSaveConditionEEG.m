triggerId = 6;
allConditions = {'bluffOrNot','highLowCards','randControl','betOrNot'};
conditionNum = 2;
condition = allConditions{conditionNum};
for subId = 10:18 
for playerRole = 1
    conditionEEG(triggerId,subId,playerRole,condition)
end
end